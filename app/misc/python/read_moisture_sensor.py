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

import RPi.GPIO as GPIO
import mcp3008
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("clock_pin", type=int, default=None, help="Clock pin for MCP3008 A/D mux")
parser.add_argument("input_pin", type=int, default=None, help="Input pin for MCP3008 A/D mux")
parser.add_argument("channel", type=int, default=None, help="Channel of desired sensor (1-8)")
args = parser.parse_args()
clock_pin = args.clock_pin
mux_pin = args.input_pin
channel = args.channel

print ("read_moisture_sensor.py")
print (clock_pin)
print (input_pin)
print (channel)
##
##
##