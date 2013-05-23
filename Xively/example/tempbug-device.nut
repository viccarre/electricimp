/*******************************************
 * 100k resistor between 3.3v and PIN9
 * NTC Thermsistor between PIN9 and PIN8
 * 
 * To read the value from the NTC:
 * 1) Drive Pin8 LOW
 * 2) Read Pin9
 * 3) Drive Pin8 HIGH
 * 
 * Current will only flow when Pin8 is LOW,
 * which is great for batteries
 ******************************************/
// Setup our hardware
NTC <- hardware.pin9;
NTC_Read_Enable <- hardware.pin8;
NTC_Read_Enable.configure(DIGITAL_OUT_OD);
NTC_Read_Enable.write(1);
NTC.configure(ANALOG_IN);

imp.configure("Living Room TempBug", [], []);

imp.setpowersave(true);

const b_therm = 3988;
const t0_therm = 298.15;

function round(x, y) {
    return (x.tofloat()/y+(x>0?0.5:-0.5)).tointeger()*y
}

function getMaxVoltage()
{
    local v_high  = 0;
    for(local i = 0; i < 10; i++){
        imp.sleep(0.01);
        v_high += hardware.voltage();
    }
    v_high = v_high / 10.0;
    return v_high;
}

function getTemperature() {
    local v_high = getMaxVoltage();
    
    NTC_Read_Enable.write(0);
    
    local val = 0;
    for (local i = 0; i < 10; i++) {
        imp.sleep(0.01);
        val += NTC.read();
    }
    val = val/10;    

    NTC_Read_Enable.write(1);

    local v_therm = v_high * val / 65535.0;
    local r_therm = 10000.0 / ( (v_high / v_therm) - 1);
    local ln_therm = math.log(10000.0 / r_therm);
    local t_therm = (t0_therm * b_therm) / (b_therm - t0_therm * ln_therm) - 273.15;
    
    return round(t_therm, 0.5);
}

function SendToXively()
{
    local temp = getTemperature();
    agent.send("SendToXively", {id = "Temperature", value = temp});
    
    imp.wakeup(900, SendToXively); // 15 minutes
}

SendToXively();