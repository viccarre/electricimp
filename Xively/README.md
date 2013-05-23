# Xively Electric Imp Library
A library for easy bi-directional communication between Xively and Electric Imp.

This library requires your account to have access to the IDE + Agent beta. If you do not have access and would like to use the library, please email info@electricimp.com.

## License
This software is released into the public domain. Anyone is free to copy, modify, publish, use, compile, sell, or distribute this software, either in source code form or as a compiled binary, for any purpose, commercial or non-commercial, and by any means.

## Features
- Generic functions for
  - Uploading datapoints
  - Downloading datapoints
  - Xively Triggers
  
## Usage
- Copy and paste the agent.nut into your agent window.
- Write your agent below the /*** END OF API CODE ***/ line

### Setting up your Xively Credentials

	Xively <- {
		FEED_ID = "FEED_ID"		// Replace "FEED_ID" with the FeedID you are writing to
		API_KEY = "API_KEY"		// Replace "API_KEY" with the API Key you created
	}	
	
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