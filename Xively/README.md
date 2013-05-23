# Xively Electric Imp Library
A library for easy bi-directional communication between Xively and an Electric Imp.

This library requires your account to have access to the IDE + Agent beta. If you do not have access, please email info@electricimp.com.

## Features
- Generic functions for
  - Uploading datapoints
  - Downloading datapoints
  - Xively Triggers
  
## Usage
- Copy and paste the agent.nut into your agent window.
- Copy and paste the device.nut code into your device window.
- Modify the Xively object in the agent to correspond to your FEED_ID and API_KEY:

	Xively <- {
    	FEED_ID = "FEED_IT"
	    API_KEY = "API_KEY"
	}
- Write your code below the /*** END OF API CODE ***/ in the agent and device windows.
	
### Pushing data to a Xively Feed

	// Create a channel and assign a value
	tempChannel <- Xively.Channel("Temperature");
	tempChannel.Set(current_temperature);
	
	// Create a feed (replace FEED_ID with the Xively FeedID you are writting to
	feed <- Xively.Feed("FEED_ID", [tempChannel]);
	
	// Update Xively
	Xively.Put(feed);

### Pulling Data from a Xively Feed

	// Create a channel
	tempChannel <- Xively.Channel("Temperature");
	
	// Create a feed (replace FEED_ID with the Xively FeedID you are writting to
	feed <- Xively.Feed("FEED_ID", [tempChannel]);
	
	// Pull from Xively
	Xively.Put(feed, Xively.API_KEY);

### Acting on Triggers from Xively

	// Create a trigger
	Xively.On(Xively.FEED_ID, "Temperature", function(trigger) {
		// if temp is above threshold value, turn LED on, otherwise turn it off
    	if (trigger.CurrentValue > trigger.ThresholdValue) { 
        	device.send("led", 1); 
	    }
    	else {
        	device.send("led", 0);
	    }
	});