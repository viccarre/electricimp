led <- hardware.pin1;
led.configure(DIGITAL_OUT);

imp.configure("Agent Example", [], []);

agent.on("setLed", function(data){
  server.log("Setting LED to " + data);
  led.write(data);  // we're assuming data will be 1 or 0
});