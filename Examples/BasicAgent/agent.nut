http.onrequest(function(request, response) {
    // check if the ledStatus is in the query parameters (?ledStatus=VALUE)
    if("ledStatus" in request.query)
    {
        // get the query parameter
        local state = request.query["ledStatus"];
        
        server.log(state);            // log it
        device.send("setLed", state); // pass it to the device
    }
    
    // send a response back.. 
    response.send(200, "OK");
});