#
# Copyright 2022 John C. Feltz, github: Feltz-UD-EE/garden_1
#
# Testing/Debugging routine
#
# args:
#   varies
# returns:
#   varies
# usage:
#   `python app/misc/python/set_gpio_mode.py`

import sys
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("clock_pin", type=int, default=None, help="Clock pin for MCP3008 A/D mux")
parser.add_argument("input_pin", type=int, default=None, help="Input pin for MCP3008 A/D mux")
parser.add_argument("channel", type=int, default=None, help="Channel of desired sensor (1-8)")
args = parser.parse_args()
clock_pin = args.clock_pin
mux_pin = args.input_pin
channel = args.channel

print ("test.py", file=sys.stderr)
print (clock_pin, file=sys.stderr)
print (mux_pin, file=sys.stderr)
print (channel, file=sys.stderr)
