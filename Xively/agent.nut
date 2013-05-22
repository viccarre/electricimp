const FEED_ID = "FEED_ID";
const API_KEY = "API_KEY";

class XivelyClient
{
    function Put(feed, ApiKey)
    {
        local url = "https://api.xively.com/v2/feeds/" + feed.FeedID + ".json";
        local headers = { "X-ApiKey" : ApiKey, "Content-Type":"application/json", "User-Agent" : "Xively-Imp-Lib/1.0" };
        local request = http.put(url, headers, feed.ToJson());

        return request.sendsync();
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
    Name = null;
    Value = null;
    
    constructor(name)
    {
        this.Name = name;
    }
    
    function Set(value) { this.Value = value; }
    
    function Get() { return this.Value; }
    
    function ToJson() { return "{ \"id\" : \"" + this.Name + "\", \"current_value\" : \"" + this.Value + "\" }"; }    
}


voltageChannel <- XivelyChannel("Voltage");
temperatureChannel <- XivelyChannel("Temperature");
aprilFeed <- XivelyFeed(FEED_ID, [voltageChannel, temperatureChannel]);

resp <- Xively.Client().Put(aprilFeed, API_KEY);
server.log(resp.statuscode + " : " + resp.body);
