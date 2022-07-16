#
# Copyright 2022 John C. Feltz, github: Feltz-UD-EE/garden_1
#
# Called from Rails application.rb and model after_save actions.
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

import Adafruit_GPIO.SPI as SPI
import Adafruit_MCP3008
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("clock_pin", type=int, default=None, help="Clock pin for MCP3008 A/D mux")
parser.add_argument("control_pin", type=int, default=None, help="Control pin for MCP3008 A/D mux")
parser.add_argument("din_pin", type=int, default=None, help="DIn pin (data shift) for MCP3008 A/D mux")
parser.add_argument("data_pin", type=int, default=None, help="Data pin (DOut) for MCP3008 A/D mux")
parser.add_argument("channel", type=int, default=None, help="Channel of desired sensor (1-8)")
args = parser.parse_args()
clock_pin = args.clock_pin
control_pin = args.control_pin
din_pin = args.din_pin
data_pin = args.data_pin
channel = args.channel

print ("read_moisture_sensor.py")
print (clock_pin)
print (control_pin)
print (din_pin)
print (data_pin)
print (channel)

mcp = Adafruit_MCP3008.MCP3008(clock_pin, control_pin, data_pin, din_pin)

value = mcp.read_adc[channel]

print(value)