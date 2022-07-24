#
# Copyright 2022 John C. Feltz, github: Feltz-UD-EE/garden_1
#
# Will be replaced with native Rails code once rpi_gpio gem is updated
#
# args:
#   clock_pin
#   mux_pin
#   index
# returns:
#   value (0-1023)
# usage:
#   value = (`python app/misc/python/set_pin_high.py 5 7 3`).to_i

import sys
import Adafruit_MCP3008
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("clock_pin", type=int, default=None, help="Clock pin for MCP3008 A/D mux")
parser.add_argument("control_pin", type=int, default=None, help="Control pin for MCP3008 A/D mux")
parser.add_argument("din_pin", type=int, default=None, help="DIn pin (data shift/MOSI) for MCP3008 A/D mux")
parser.add_argument("data_pin", type=int, default=None, help="DOut pin (data/MISO) for MCP3008 A/D mux")
parser.add_argument("channel", type=int, default=None, help="Channel of desired sensor (1-8)")
args = parser.parse_args()
clock_pin = args.clock_pin
control_pin = args.control_pin
din_pin = args.din_pin
data_pin = args.data_pin
channel = args.channel

print ("read_moisture_sensor.py", file=sys.stderr)
print ("clock_pin = " + str(clock_pin), file=sys.stderr)
print ("control_pin = " + str(control_pin), file=sys.stderr)
print ("din_pin = " + str(din_pin), file=sys.stderr)
print ("data_pin = " + str(data_pin), file=sys.stderr)
print ("channel = " + str(channel), file=sys.stderr)
print ("mcp call is ... clock, control, data, din === CLK, CS, MISO, MOSI", file=sys.stderr)

mcp = Adafruit_MCP3008.MCP3008(clock_pin, control_pin, data_pin, din_pin)

print ("MCP connection established", file=sys.stderr)

value = mcp.read_adc(channel)

print(value)