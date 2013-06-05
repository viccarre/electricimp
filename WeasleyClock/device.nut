const StepsPerFullRotation = 200;
const TimeBetweenSteps = 0.005;

class Stepper
{
    pinArray = null;
    currentPosition = null;         // 0
    stepsPerFullRotation = null;    // 200
    pin = null;                     // id for pinArray
    delayTime = null;               // seconds
    
    constructor(_firstPin, _secondPin, _thirdPin, _fourthPin, _stepsPerFullRotation, _delayTime)
    {
        pinArray = [_firstPin, _secondPin, _thirdPin, _fourthPin];
        for (local i = 0; i < 4; i++)
        {
            pinArray[i].configure(DIGITAL_OUT);
            pinArray[i].write(0);
        }
        
        stepsPerFullRotation = _stepsPerFullRotation;
        delayTime = _delayTime;
        
        currentPosition = 0;
        pin = 0;
    }
    
    function StepForward()
    {
        currentPosition++;
        pin = (pin + 1);
        if (pin > 3) pin = 0;
        pinArray[pin].write(1);
        imp.sleep(delayTime);
        pinArray[pin].write(0);
    }
    function StepForwards(steps)
    {
        server.log("Stepping forwards " + steps);
        for (local i = 0; i < steps; i++)
            StepForward();
    }

    function StepBackward()
    {
        currentPosition--;
        pin = (pin - 1);
        if (pin < 0) pin = 3;
        pinArray[pin].write(1);
        imp.sleep(delayTime);
        pinArray[pin].write(0);
    }
    function StepBackwards(steps)
    {
        server.log("Stepping backwards " + steps);
        for (local i = 0; i < steps; i++)
            StepBackward();
    }
    
    function MoveTo(location)
    {
        local diff = currentPosition - location;
        server.log("moving from " + currentPosition + " to " + location);
        
        if (diff > 0)
        {
            if (diff < 100)
                StepBackwards(diff);
            else
                StepForwards(stepsPerFullRotation - diff);
        }
        else
        {
            if (diff > -100)
                StepForwards(math.abs(diff));
            else
                StepBackwards(stepsPerFullRotation + diff);
        }
        currentPosition = location;
        imp.sleep(1.0);
    }
    
    function Zero()
    {
        currentPosition = 0;
    }
}

class LocationClock
{
    stepper = null;
    locations = null;
    numLocations = null;
    stepsPerLocation = null;
    
    constructor(_locations, _stepper)
    {
        this.stepper = _stepper;
        this.locations = _locations;
        this.numLocations = locations.len();
        this.stepsPerLocation = stepper.stepsPerFullRotation / numLocations;
    }
    
    function MoveTo(location)
    {
        local position = GetLocationsPosition(location);
        if (position != null){
            stepper.MoveTo(position);
        }
    }
    
    function GetLocationsPosition(location)
    {
        for (local i = 0; i < numLocations; i++) {
            if (location.tolower() == locations[i].tolower()) {
                return i * stepsPerLocation;
            }
        }
        return null;
    }
    
    function Zero() {
        stepper.Zero();
    }
}   

stepper <- Stepper(hardware.pin2, hardware.pin7, hardware.pin5, hardware.pin8, StepsPerFullRotation, TimeBetweenSteps);
locations <- ["Home", "Relax", "Coffee", "Prison", "Lost", "Travel", "Work", "Hospital"];
locationClock <- LocationClock(locations, stepper);

agent.on("Zero", function(data){
    server.log("Zero'ing clock")
    locationClock.Zero();
});

agent.on("MoveTo", function(location) {
    server.log("Trying to move to: " + location);
    locationClock.MoveTo(location);
});

// watchdog so it never goes into deep sleep
function watchdog() {
    imp.wakeup(900, watchdog);
} watchdog();