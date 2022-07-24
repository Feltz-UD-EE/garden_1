#
# Copyright 2022 John C. Feltz, github: Feltz-UD-EE/garden_1
#
# Will be replaced with native Rails code once rpi_gpio gem is updated
#
# args:
#   pin_id
# returns:
#   nothing
# usage:
#   `python app/misc/python/set_pin_high.py 5`

import RPi.GPIO as GPIO
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("pin", type=int, default=None, help="Pin # to set high")
args = parser.parse_args()
pin = args.pin

print ("set_pin_high.py", file=sys.stderr)
print (pin, file=sys.stderr)
GPIO.setmode(GPIO.BCM)        # no persistence
GPIO.setup(pin, GPIO.OUT)
GPIO.output(pin, 1)