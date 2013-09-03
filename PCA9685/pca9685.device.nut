imp.configure("ImpBot", [], []);
const PCA9685_DEFAULT_ADDR = 0x80;

class PCA9685 {
    PCA9685_MODE1 = 0x00;
    PCA9685_PRESCALE = 0xFE; 
    
    SERVO_MIN = 150;
    SERVO_MAX = 600;
    
    LED0_ON_L =0x6;
    
    i2c = null;
    addr = null;
    
    // _i2c: A configured I2C bus (400MHz)
    // _addr: optional I2C base address (default = PCA9685_ADDR = 0x80)
    // _freq: optional PWM frequency
    constructor(_i2c, _addr = PCA9685_DEFAULT_ADDR, _freq = null) {
        this.i2c = _i2c;
        this.addr = _addr;
        
        reset();
        if (_freq) {
            this.setFrequency(_freq);
        }
    }
    
    function reset() {
        i2c.write(this.addr, format("%c", 0x00));
        i2c.write(this.addr, format("%c%c", PCA9685_MODE1, 0x00));
    }
    
    function setFrequency(f) {
        local prescaleval = 25000000;
        prescaleval /= 4096;
        prescaleval /= f;
        prescaleval -= 1;
        local prescale = math.floor(prescaleval + 0.5);
        
        i2c.write(this.addr, format("%c", PCA9685_MODE1));
        local oldmode = i2c.read(this.addr, "", 1);
        local newmode = (oldmode[0]&0x7F) | 0x10; 
        i2c.write(this.addr, format("%c%c", PCA9685_MODE1, newmode));
        i2c.write(this.addr, format("%c%c", PCA9685_PRESCALE, prescale));
        i2c.write(this.addr, format("%c%c", PCA9685_MODE1, oldmode[0]));
        imp.sleep(0.005);
        i2c.write(this.addr, format("%c%c", PCA9685_MODE1, (oldmode[0] | 0xa1)));
    }
    
    function setServo(servo, on, off) {
        //set the PWM for servo and c
        local d = format("%c%c%c%c%c", (LED0_ON_L+4*servo), on, (on>>8), off, (off>>8));
        i2c.write(this.addr, d);
    }
}

i2c <- hardware.i2c12;
i2c.configure(CLOCK_SPEED_400_KHZ);
servoBus <- PCA9685(i2c, 0x80, 60);


const SERVO_MIN = 160;
const SERVO_MAX = 600;

c <- SERVO_MIN;

function test() {
  servoBus.setServo(4, 0, c);
  
  c += 10;
  if (c >= SERVO_MAX) c = SERVO_MIN;
  
  //imp.wakeup(0.125, test);
} test();

server.log("done");g