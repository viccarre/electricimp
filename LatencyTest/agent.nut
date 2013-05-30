device.on("ping", function(data) {
    server.log("ping: " + data);
    device.send("pong", data);
});