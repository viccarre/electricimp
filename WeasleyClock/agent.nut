http.onrequest(function(request, response){
    local code = 200;
    local message = "OK";
    
    local data = http.urldecode(request.body);
    switch(request.method)
    {
        case "POST":
            if ("zero" in data){
                device.send("Zero", null);
            } else if ("location" in data) {
                device.send("MoveTo", data.location);
            }
        break;
    }
    response.send(code, message);
});