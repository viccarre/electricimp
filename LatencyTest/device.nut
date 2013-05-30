imp.configure("LatencyTest", [], []);

buttonState <- null;
button <- hardware.pin1;
led <- hardware.pin9;

function buttonPress()
{
    local newState = button.read();
    if (buttonState == newState) return;
    
    buttonState = newState;
    agent.send("ping", buttonState)
}

button.configure(DIGITAL_IN_PULLUP, buttonPress);
led.configure(DIGITAL_OUT);
buttonState = button.read();
led.write(1);

agent.on("pong", function(data){
    server.log("pong: " + data);
    led.write(data); 
});