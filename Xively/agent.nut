const FEED_ID = "FEED_ID";
const API_KEY = "API_KEY";

class XivelyClient
{
    /*****************************************
     * method: PUT
     * IN:
     *   feed: a XivelyFeed we are pushing to
     *   ApiKey: Your Xively API Key
     * OUT:
     *   HttpResponse object from Xively
     *   200 and no body is success
     *****************************************/
    function Put(feed, ApiKey)
    {
        local url = "https://api.xively.com/v2/feeds/" + feed.FeedID + ".json";
        local headers = { "X-ApiKey" : ApiKey, "Content-Type":"application/json", "User-Agent" : "Xively-Imp-Lib/1.0" };
        local request = http.put(url, headers, feed.ToJson());

        return request.sendsync();
    }
    
    /*****************************************
     * method: GET
     * IN:
     *   feed: a XivelyFeed we fulling from
     *   ApiKey: Your Xively API Key
     * OUT:
     *   An updated XivelyFeed object on success
     *   null on failure
     *****************************************/
    function Get(feed, ApiKey)
    {
        local url = "https://api.xively.com/v2/feeds/" + feed.FeedID + ".json";
        local headers = { "X-ApiKey" : ApiKey, "User-Agent" : "xively-Imp-Lib/1.0" };
        local request = http.get(url, headers);
        local response = request.sendsync();
        if(response.statuscode != 200) {
            server.log("error sending message: " + response.body);
            return null;
        }
        
        local channel = http.jsondecode(response.body);
        for (local i = 0; i < channel.datastreams.len(); i++)
        {
            for (local j = 0; j < feed.Channels.len(); j++)
            {
                if (channel.datastreams[i].id.tolower() == feed.Channels[j].id.tolower())
                {
                    //server.log(channel.datastreams[i].id + " : " + channel.datastreams[i].current_value);
                    feed.Channels[j].current_value = channel.datastreams[i].current_value;
                    break;
                }
            }
        }
        
        return feed;
    }
}

class XivelyFeed
{
    FeedID = null;
    Channels = null;
    
    constructor(feedID, channels)
    {
        this.FeedID = feedID;
        this.Channels = channels;
    }
    
    function GetFeedID() { return FeedID; }

    function ToJson()
    {
        local json = "{ \"datastreams\": [";
        for (local i = 0; i < this.Channels.len(); i++)
        {
            json += this.Channels[i].ToJson();
            if (i < this.Channels.len() - 1) json += ",";
        }
        json += "] }";
        return json;
    }
}

class XivelyChannel
{
    id = null;
    current_value = null;
    
    constructor(_id)
    {
        this.id = _id;
    }
    
    function Set(value) { this.current_value = value; }
    
    function Get() { return this.current_value; }
    
    function ToJson() { return "{ \"id\" : \"" + this.id + "\", \"current_value\" : \"" + this.current_value + "\" }"; }    
}

// Create some channels
voltageChannel <- XivelyChannel("Voltage");
temperatureChannel <- XivelyChannel("Temperature");

// Create a feed and initialize from Xively
aprilFeed <- XivelyFeed(FEED_ID, [voltageChannel, temperatureChannel]);
XivelyClient().Get(aprilFeed, API_KEY);

// Update some values locally
voltageChannel.Set(3.3);
temperatureChannel.Set(23.5);

// Push to Xively
resp <- XivelyClient().Put(aprilFeed, API_KEY);
server.log(resp.statuscode + " : " + resp.body);