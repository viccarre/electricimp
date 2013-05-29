class LEDController{
    pin = null;
    colour = null
    state = 0;
    
    constructor(ledPin, ledColour){
        pin = ledPin;
        colour = ledColour;
        pin.configure(DIGITAL_OUT);
    }
    
    function TurnOn(){
        Write(1);
    }
    
    function TurnOff(){
        Write(0);
    }
    
    function Write(newState){
        if (newState == 0 || newState == 1)
        {
            state = newState;
            server.log(colour + ": " + newState);
            agent.send("set" + colour, newState);
            pin.write(newState);
        }
        else
        {
            server.log(newState + " is not a valid LED state. Please use 0 or 1.");
        }
        
    }
};

local RedLED = LEDController(hardware.pin2, "Red");
local GreenLED = LEDController(hardware.pin5, "Green");

RedLED.TurnOff();
GreenLED.TurnOff();

agent.on("setGreen", function(state) {
    GreenLED.Write(state);
});

agent.on("setRed", function(state) {
    RedLED.Write(state);
});

imp.configure("Red Light Green Light",[],[]);