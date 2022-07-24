#
# Copyright 2022 John C. Feltz, github: Feltz-UD-EE/garden_1
#
# Will be replaced with native Rails code once rpi_gpio gem is updated
#
# args:
#   pin_id
# returns:
#   value (0 or 1)
# usage:
#   `python app/misc/python/get_pin_state.py 5`

import RPi.GPIO as GPIO
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("pin", type=int, default=None, help="Pin # to set high")
args = parser.parse_args()
pin = args.pin

print ("get_pin_state.py", file=sys.stderr)
print (pin, file=sys.stderr)
GPIO.setmode(GPIO.BCM)        # no persistence
GPIO.setup(pin, GPIO.IN)
value = GPIO.input(pin)
print (value)