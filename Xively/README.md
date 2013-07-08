# Xively Electric Imp Sample Code
Sample code for easy bi-directional communication between Xively and Electric Imp.

This sample code requires your account to have access to the IDE + Agent beta. If you do not have access and would like to use the sample code, please email info@electricimp.com.

## License
The MIT License (MIT)

Copyright (c) 2013 electric imp, inc

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

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
The callback function MUST include a single parameter that contains the trigger data.

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
