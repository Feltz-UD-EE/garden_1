#
# Copyright 2022 John C. Feltz, github: Feltz-UD-EE/garden_1
#
# Tanks: sources of water
#
#       t.string  :name
#       t.integer :volume               # liters
#       t.integer :pump_pin
#       t.integer :sensor_pin           # 'MISO' in Adafruit python package
#       t.integer :sensor_index         # pin & index composite unique
#       t.integer: child_id             # self-referential
#       t.timestamps

# require 'rpi_gpio'

class Tank < ApplicationRecord
    # statics & enums

    # All this below duplicated with zones; need to DRY up
                                    # 3 for MCP3008 can be in common for all MCP3008 A/D mux chips
    MCP3008ClockPin = 4             # CLK: chip pin # 13
    MCP3008ControlPin = 17          # CS/SHDN: chip pin # 10
    MCP3008DInPin = 11              # DIN: chip pin 11 ("MOSI" in python package)
    SensorPowerPin = 22             # Don't keep sensors powered on all the time

    # relations
    has_many :zones
    has_one :child_tank, class_name: 'Tank', foreign_key: child_id, optional: true
    belongs_to :parent_tank, class_name: 'Tank', optional: true

    # validations
    validates :name, presence: true
    validates :pump_pin, presence: true

    # scopes

    # class methods

    # instance methods
    def low_level
        self.level_readings.descending.first.low?
    end

    def needs_pumping
        (self.zones.any? && self.zones.planted.map { |z| z.needs_water }.include?(true)) ||
        (self.child_tank.any? && self.child_tank.low_level)
    end

    def pump_on
#         RPi::GPIO.set_high self.pump_pin
      `python app/misc/python/set_pin_high.py #{self.pump_pin}`
      p "Turning on pump for #{self.name}"
    end

    def pump_off
#         RPi::GPIO.set_low self.pump_pin
      `python app/misc/python/set_pin_low.py #{self.pump_pin}`
      p "Turning off pump for #{self.name}"
    end

    # Callbacks
    after_save do
    #         RPi::GPIO.setup self.pump_pin, :as => :output
    end

end
