
// --------------------------------------------------------------------------
// Configure Twitter client
var config = require('./config');
var ntwitter = require('ntwitter');
var twitter = new ntwitter(config.twitter);
var crypto = require('crypto');


// --------------------------------------------------------------------------
// Initialise the stream
var new_tracks = [];
var all_tracks = [];
var all_track_timestamps = {};
var all_tracks_md5 = null;
var current_stream = null;


// Check for new tracks, every 10 seconds
function checkStream() {
	if (new_tracks.length > 0) {

		// Dedupe the all_tracks array
		var prev, keepers = [];
		all_tracks = all_tracks.concat(new_tracks).sort();
		all_tracks.forEach(function (item, pos) {
			if (typeof item != 'undefined') {
				// is the previous item different from this one?
				if (prev !== item) keepers.push(pos);
			}
			prev = item;
		});
		all_tracks = keepers.map(function (pos) { return all_tracks[pos]; });

		// See if the signature has changed
		var new_md5 = crypto.createHash('md5').update(all_tracks.join("|")).digest("hex");
		if (all_tracks_md5 !== new_md5) {
			all_tracks_md5 = new_md5;

			// Remove the old stream
			if (current_stream) {
				current_stream.destroy();
				current_stream = null;
			}

			// Start a new stream
			if (all_tracks.length > 0) {
				twitter.stream ('statuses/filter', { track: all_tracks } , function(stream) { 
					current_stream = stream;
					stream.on('data', receive_tweet); 
					stream.on('error', function (err, result) { console.log("Twitter streaming error: ", err, result) }); 
				});
			}
		}
	}
}
setInterval(checkStream, 10000);


// Check for old tracks (15 minutes max) every minute
function checkTracks() {
	var rebuild = false;
	var now = new Date().getTime();
	for (var i = all_tracks.length-1; i >= 0; i--) {
		var track = all_tracks[i];
		if (now - all_track_timestamps[track] > 900000) {
			console.log("Removing old track: " + track);
			all_tracks.splice(i, 1);
			delete all_track_timestamps[track];
			rebuild = true;
		}
	};
	if (rebuild) {
		new_tracks = all_tracks;
		all_tracks = [];
	}
}
setInterval(checkTracks, 60000);


// --------------------------------------------------------------------------
// Configure the web server
var express = require('express');
global.app = express();
app.enable('trust proxy');
app.use(express.bodyParser());


// --------------------------------------------------------------------------
// Setup the routes
app.get("/follow/:track", function (req, res) {
	// Sit and wait for a response on one track
	follow(req, res, [req.params.track]);
});

app.post("/follow", function (req, res) {
	// Extract the tracks
	var tracks = [];
	if ("track" in req.body) tracks.push(req.body.track);
	if ("tracks" in req.body) req.body.tracks.forEach(function(track) {
		tracks.push(track);
	})

	// Sit and wait for a response
	follow(req, res, tracks);
});


// --------------------------------------------------------------------------
// Configure faye
var faye = require('faye');
var faye_server = new faye.NodeAdapter({mount: '/faye', timeout: 60, ping: 30});
faye_server.listen(config.faye.worker_port);
faye_client = faye_server.getClient();


// --------------------------------------------------------------------------
// Start the http and https servers
var http = require('http');
http.createServer(app).listen(config.http.port, "0.0.0.0", 50000);


// --------------------------------------------------------------------------
// When a client long polls it subscribes to faye once for each track
function follow(req, res, tracks) {

	// Split out all the tracks
	var channels = [];
	tracks.forEach(function (track) {
		if (track.length > 3) {
			track = track.toLowerCase();
			var channel = "/track/" + track;
			console.log("Subscribing to:", channel);
			channels.push(channel);
			new_tracks.push(track);
			all_track_timestamps[track] = new Date().getTime();
		}
	});

	// Subscribe to all the tracks requested
	faye_client.subscribe(channels, function (tweet) {
		console.log("Received tweet from:", tweet.screen_name);
		faye_client.unsubscribe(channels);
		res.send(tweet);
	});

	// Handle disconnects from client
	req.on('close', function () {
		console.log("Disconnection detected.");
		faye_client.unsubscribe(channels);
	});
}


// --------------------------------------------------------------------------
// When a tweet arrives, split it into words and publish each word to faye
function receive_tweet(tweet) {

	// console.log(tweet.user.screen_name, ":", tweet.text.substring(0, 100));

	var words = tweet.text.match(/[a-z0-9]+/gi);
	var tweet = { screen_name: tweet.user.screen_name, text: tweet.text};
	words.forEach(function(word) {
		if (word.length > 3) {
			word = word.toLowerCase();
			// console.log("Publishing to:", "/track/" + word);
			faye_client.publish("/track/" + word, tweet);
		}
	});
}
