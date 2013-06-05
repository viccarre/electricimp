# WeasleyClock
The WeasleyClock is the result of an internal hackathon at Electric Imp. I wanted to recreate the Weasley's magical clock that showed where everyone was (instead of what time it was). I had intended it to be a really simple hardware project, and do cool things like have the clock automagically change based on geolocated tweets, foursquare checkins, etc.

I decided to use a bi-polar stepper motor (as opposed to a servo) for a number of reasons, but it made the build a lot more complex (on top of building a motor control board, I also had to learn how stepper motors work). This is the first pass at the hardware and software, it would be nice to improve on it in the future.

[Here's](https://vine.co/v/bQvnwFq1Vjj) a video that shows the stepper motor + driver board running for the first time..

And [here's](https://vine.co/v/bQ6W3r3HEMi) a video of the clock itself.

## Hardware
I used a [L293DNE](http://www.mouser.com/ProductDetail/Texas-Instruments/L293DNE/?qs=ZA235jQDfbp/p7f5ThcsUA==) to control the stepper motor, and the reference design on page 10 of the [datasheet](http://www.mouser.com/ds/2/405/slrs008c-128230.pdf).