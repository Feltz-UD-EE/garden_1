# garden_1

A fully-automated garden watering system, using a RaspberryPi, that can run off-grid.

Install a pump on your rain barrel, define any number of zones in your garden with different crops, run irrigation lines from the pump with solenoid valves, place a moisture sensor in each zone, and wire everything up to the Raspberry Pi and a power supply.

## Software Installation

### RPi
Set up your Raspberry Pi with the standard OS.  This will include Python, Rails, and many standard libraries.

### Rails

Clone the github repository.

Run bundler to install necessary Ruby gems.

```
bundle install
```

Initialize the database

```
rails db:migrate
```

### Python libraries

Use your preferred Python package manager (such as pip or Anaconda) to install the following Python packages:
```
Adafruit_MCP3008
RPi
```

### Database

This project uses the sqlite database, with disk storage in the `/db` directory.  If you prefer a more robust DBMS such as Postgres, install it and make the appropriate changes to the Rails configuration files.

## Hardware

garden_1 assumes a Raspberry Pi with a full 40-pin BCM.  Other necessary hardware includes:
* An MCP3008 multiplexing A/D converter for every 8 moisture sensors
* Moisture sensors (3.3V/5V analog sensors with an interface board)
* One or more 12V DC inline water pumps
* A 12V DC solenoid water valve for each moisture sensor
* Drip irrigation lines
* A breadboard with a variety of jumper wires
* Several colors of 18-22 AWG wire
* 5V relays to control the flow of 12V power to the valves and pumps
* A 12V DC power supply (for the valves and pump)
* A 5V DC power supply (for the RaspberryPi, sensors, and breadboard components)

### Hardware Installation Suggestions

Mount termination blocks to connect the semi-permanent wires that run to the garden beds from the jumpers that connect directly to the Raspberry Pi and breadboard.

Use different colored wires to easily distinguish between power, ground, and signal.

Practice good cable management.

## Configuration

### Power and Ground

It is important that all the grounds be tied together and made common.

The 12V supply for the valves and pumps does not need to be clean or steady; you can use a large 12V battery with a solar recharger, and the valves and pumps will probably work if the voltage drops to 9-10V.

The 5V supply for the Raspberry Pi and other electronics, however, should deliver good quality power with surge protection.

### Physically Wire the Sensors

Each sensor needs 3.3V power, ground, and an analog data line.  Power and ground can be common to all sensors.
* Ground should connect to the system ground
* Power should connect to the Raspberry Pi BCM pin 22 - see `SensorPowerPin` as defined in `app/models/zone.rb`.  NB: BCM pin 22 is physical pin 15.
* The analog data line should connect to any free pin 1-8 of an MCP3008 (which corresponds to channels 0-7).  Keep careful track of which pin you use, as you will need to enter it into the software during configuration. 

After wiring, insert the sensors into the soil.  You may want to use small lengths of PVC pipe with a cap to mark the location of the sensor so that you don't step on it or trip over the wiring.

### Physically Wire the Multiplexers

Each MCP3008 needs power, ground, several control lines, and an output line.  You will have already connected the analog moisture sensors to them in the previous step.
* Ground: MCP3008 pins 9 and 14 should connect to the system ground
* Digital power: MCP3008 pin 16 should connect to 5V power
* Analog power: MCP3008 pin 15 should connect to Raspberry Pi BCM pin 22 (along with the sensors above)
* CLK (clock): MCP3008 pin 13 should connect to the Raspberry Pi BCM pin 4 - see `MCP3008ClockPin` as defined in `app/models/zone.rb`.  NB: BCM pin 4 is physical pin 7.
* CS (control): MCP3008 pin 10 should connect to the Raspberry Pi BCM pin 17 - see `MCP3008ControlPin` as defined in `app/models/zone.rb`.  NB: BCM pin 17 is physical pin 11.
* DIN (data shift): MCP3008 pin 11 should connect to the Raspberry Pi BCM pin 11 - see `MCP3008DInPin` as defined in `app/models/zone.rb`.  NB: BCM pin 11 is physical pin 23.
* DOUT (data out): MCP3008 pin 12 should connect to an open BCM pin on the Raspberry Pi, such as BCM pin 2 or 3.  Keep careful track of which pin you use, as you will need to enter it into the software during configuration.

If you are using multiple MCP3008s, you can connect their CLK, CS, and DIN pins in parallel using short jumper wires.

### Physically Wire the Valves and Pumps

Each valve needs switched 12V power and ground.  Each pump needs the same.
* Ground should be the system ground
* Power should be the output of a relay; each valve and pump requires its own relay.

### Physically Wire the Relays

Each relay needs ground, 12V power, 5V power, and a control line.
* Ground should be the system ground
* 12V power can be common to all relays
* 5V power is used as a comparator for the input signal
* Control for each relay should connect to an open BCM pin on the Raspberry Pi, such as BCM pin 23, 24, 25, etc. Keep careful track of which pin you use, as you will need to enter it into the software during configuration.

## Setting up Your Garden

### Launch and create an account

Start the software with `rails s` and point your browser at `localhost:3000`.  You will see a blank home page.  Click on the 'Create an Account' link and follow the instructions (if you are running in the development environment, you may need to grab the account confirmation code from the console and manually paste it into the browser).

### Configure Tanks and Zones

Click on 'New Tank'.  The value for 'pump pin' should match the BCM pin that controls the relay connected to the tank.  Then save the tank and return to the home page.

Click on 'New Zone'.  Enter appropriate information.  If you do not enter a crop, the zone will be inactive: neither the moisture sensor nor the valve will operate.
* The value for 'valve pin' should match the BCM pin that controls the relay connected to the valve for that zone.
* The value for 'sensor pin' should match the BCM pin that connects to the MCP 3008 DOUT line for that zone's moisture sensor.
* The value for 'sensor index' should match the MCP3008 channel (0-7) that the sensor's analog data line is connected to.  Be careful of off-by-one errors: the MCP3008 physical pin numbering is 1-8, but the channel numbering is 0-7.  Always use the channel numbering for 'sensor index'.
* The value for 'moisture target' is the level at which you want to irrigate.  This number can vary from 0-1023.  Be aware that this is an inverted scale, with 1023 being very dry and 0 being very wet.  Typically, numbers in the range of 400-800 are appropriate for moisture threshold.

Then save the zone and return to the home page.  Create as many zones as you have valves and sensors.

### Moisture Readings

Every 15 minutes, the software will turn on all the moisture sensors briefly in order to read the soil moisture.  It will then open and close the valves, and turn on the pumps, in order to supply water any zones that need watering.  You can change this timing by editing `app/jobs/moisture_readings_job/rb` and changing the value of the constant `RUN_EVERY`.

Refresh the home page to see the most recent moisture reading, and drill down into a zone to see past moisture readings.

## Security

The security model for garden_1 assumes a small number of authorized users, who are able to change configurations through the Web UI, and public access without an account, which only allows the ability to view a few pages.

After creating your user accounts, you can comment out the account creation page in `app/viws/rodauth/create_account.html.erb` to prevent any future account creation.

If you are not connecting this directly to the Internet (or only accessing with a secured VPN), then you do not need to worry about disabling account creation.

## Usage Suggestions

Set the initial moisture threshold for each zone at 500 until you have some data about your garden, and can correlate the moisture level with actual plant growth.

## Change Log

1.0.0:  Initial release

## Contributing

Pull requests and feature suggestions are welcome.  Please see the Wiki page for Future Enhancements to see what's on the roadmap.
