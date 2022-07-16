#
# Copyright 2022 John C. Feltz, github: Feltz-UD-EE/garden_1
#
# Called from Rails application.rb.
# Will be replaced with native Rails code once rpi_gpio gem is updated
#
# args:
#   mode
# returns:
#   nothing
# usage:
#   `python app/misc/python/set_gpio_mode.py`

import RPi.GPIO as GPIO
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("mode", type=str, choices = ["BCM", "BOARD"], default="BCM", help="Pin numbering mode")
args = parser.parse_args()
mode = args.mode

print ("set_gpio_mode.py")
print (mode)
if (mode == "BCM"):
  print ("setting mode to BCM")
  GPIO.setmode(GPIO.BCM)
else:
  print ("setting mode to BOARD")
  GPIO.setmode(GPIO.BOARD)
