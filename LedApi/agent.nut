local greenState = 0;
local redState = 0;

device.on("setRed", function(data) {
    redState = data;
});

device.on("setGreen", function(data) {
    greenState = data;
});

http.onrequest(function(request, response) {
    local code = null;
    local message = null;
    
    if (request.path == "/lights")
    {
        if (request.method == "GET")
        {            
            code = 200;
            message = "{ 'red': " + redState + ", 'green': " + greenState + " }";
        }
        else if (request.method == "POST")
        {
            try {
                local data = http.jsondecode(request.body);
                if ("red" in data)
                {
                    server.log("red: " + data.red);
                    device.send("setRed", data.red);
                }
                if("green" in data)
                {
                    server.log("green: " + data.green);
                    device.send("setGreen", data.green);
                }
                code = 200;
                message = "OK";
            }
            catch (e) {
                code = 501;
                message = "Unacceptable";
                server.log(e);
            }
        }
    }
    else
    {
        code = 404; 
        message = "Not Found";
    }
 
    response.send(code, message);
});