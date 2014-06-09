button <- hardware.pin1;
button2 <- hardware.pin7;
 
function buttonPress() 
{
    local state = button.read();
    if (state == 1) 
    {
        // The button is released
        
        server.log("Release");
        agent.send("SendToXively", {id = "sensor1", value = 0});
        
        
    } else 
    {
        // The button is pressed
        
        server.log("Press");
        agent.send("SendToXively", {id = "sensor1", value = 1});
        
    }
}

function button2Press(){
   
    local state = button2.read();
    if ( state == 1){
        server.log("Button 2 Release");
        agent.send("SendToXively", {id = "sensor2", value = 0});
        
    } else{
        
        server.log("Button 2 Press");
        agent.send("SendToXively", {id = "sensor2", value = 5});
    }
}

button.configure(DIGITAL_IN_PULLUP, buttonPress);
button2.configure(DIGITAL_IN_PULLUP, button2Press);

