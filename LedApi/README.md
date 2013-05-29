# LED API
This is a sample project for the Electric Imp that demonstrates how to control hardware through an API using the agents http.onrequest function.

## API Calls
/lights (GET) - Returns state of all the LEDs. Returns the following object:

	{ "red" : 1, "green": 0 }

/lights (POST) - sets the state of LEDs and triggers hardware. Expects the following object:

	{ "red" : 1, "green": 0 }
	    
### Return Codes
200 - On Success
501 - Invalid JSON
404 - Unknown URL path