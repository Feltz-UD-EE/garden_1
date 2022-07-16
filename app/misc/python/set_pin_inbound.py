#
# Copyright 2022 John C. Feltz, github: Feltz-UD-EE/garden_1
#
# Called from Rails application.rb and model after_save actions.
# Will be replaced with native Rails code once rpi_gpio gem is updated
#
# args:
#   pin_id
# returns:
#   nothing
# usage:
#   `python app/misc/python/set_pin_inbound.py 5`

import RPi.GPIO as GPIO
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("pin", type=int, default=None, help="Pin # to set as an input pin")
args = parser.parse_args()
pin = args.pin

print ("set_pin_inbound.py")
print (pin)
GPIO.setup(pin, GPIO.IN)
