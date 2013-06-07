
var config = {};

// Imp/API http server
config.http = {};
config.http.port = 9001;
config.http.sport = 9443;

// Faye configuration
config.faye = {};
config.faye.port = 9002;

// Twitter API configuration
config.twitter = {};
config.twitter.consumer_key = '';
config.twitter.consumer_secret = '';
config.twitter.access_token_key = '';
config.twitter.access_token_secret = '';

// Done, return.
module.exports = config;

