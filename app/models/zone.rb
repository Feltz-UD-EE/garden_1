#
# Copyright 2022 John C. Feltz, github: Feltz-UD-EE/garden_1
#
# Zones: planted areas, usually 1 crop (or closely related plants)
#   * a zone is typically 1 or 2 rows, or half of a 4'x8' raised bed (~16 square feet, ~1.5 square meters)
#

#
#       t.string  :name
#       t.string  :number
#       t.references :tank
#       t.string  :crop
#       t.string  :description
#       t.integer :valve_pin
#       t.integer :sensor_pin             # pin & index composite unique
#       t.integer :sensor_index
#       t.integer :moisture_target        # 0-1023
#       t.timestamps
#

# require 'rpi_gpio'

class Zone < ApplicationRecord
    # statics & enums
    SensorMultiplexClockPin = 1              # all 3 of these still TBD
    SensorMultiplexAddressingPin = 2
    SensorPowerPin = 3
    MaxMoisture = 0                            # moisture scale inverted, as it is the raw resistance level from sensor
    MinMoisture = 1023

    # relations
    belongs_to :tank
    has_many :moisture_readings

    # validations
    validates :name, presence: true
    validates :number, presence: true
    validates :valve_pin, presence: true
    validates :sensor_pin, presence: true
    validates :sensor_index, presence: true
    validates :sensor_index, uniqueness: {scope: :sensor_pin}
    validates :moisture_target, presence: true
    validate  :moisture_target_in_limits

    def moisture_target_in_limits           # NB moisture scale inverted
        if moisture_target > MinMoisture || moisture_target < MaxMoisture
            errors.add(:moisture_target, "must be in range #{MaxMoisture}-#{MinMoisture}")
        end
    end

    # scopes
    scope :planted, -> { where("crop IS NOT NULL") }
    scope :ascending, -> { order(number: :asc) }

    # class methods
    def self.moisture_sensors_activate
        RPi::GPIO.setup Zone.sensor_multiplex_clock_pin, :as => :output
        RPi::GPIO.setup Zone.sensor_multiplex_addressing_pin, :as => :output
        RPi::GPIO.setup Zone.sensor_power_pin, :as => :output
        RPi::GPIO.set_high Zone.sensor_power_pin
        # ?? translate from example python code
    end

    def self.moisture_sensors_deactivate
        RPi::GPIO.setup Zone.sensor_multiplex_clock_pin, :as => :output
        RPi::GPIO.setup Zone.sensor_multiplex_addressing_pin, :as => :output
        RPi::GPIO.setup Zone.sensor_power_pin, :as => :output
        RPi::GPIO.set_low Zone.sensor_multiplex_clock_pin
        RPi::GPIO.set_low Zone.sensor_multiplex_addressing_pin
        RPi::GPIO.set_low Zone.sensor_power_pin
    end

    # instance methods
    def take_reading
        # Use Rpi on pin = self.sensor_pin and self.sensor_index
        RPi::GPIO.setup self.sensor_pin, :as => :input
        value = nil  # ?? translate from example python code
        self.moisture_readings.create(value: value)
    end

    def latest_reading
        self.moisture_readings.descending.first.present? ? self.moisture_readings.descending.first.value : MinMoisture
    end

    def needs_water
        self.latest_reading < self.moisture_target
    end

    def valve_open
        RPi::GPIO.setup self.valve_pin, :as => :output
        RPi::GPIO.set_high self.valve_pin
    end

    def valve_close
        RPi::GPIO.setup self.valve_pin, :as => :output
        RPi::GPIO.set_low self.valve_pin
    end

end

