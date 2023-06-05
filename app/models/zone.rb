#
# Copyright 2022 John C. Feltz, github: Feltz-UD-EE/garden_1
#
# Zones: planted areas, usually 1 crop (or closely related plants)
#   * a zone is typically 1 or 2 rows, or half of a 4'x8' raised bed (~16 square feet, ~1.5 square meters)
#

#
#       t.string  :name
#       t.integer :number
#       t.references :tank
#       t.string  :description
#       t.integer :valve_pin
#       t.integer :sensor_pin             # 'MISO' in Adafruit python package
#       t.integer :sensor_index           # pin & index composite unique
#       t.integer :moisture_target        # 0-1023
#       t.timestamps
#

# require 'rpi_gpio'

class Zone < ApplicationRecord
    # statics & enums
                                    # 3 for MCP3008 can be in common for all MCP3008 A/D mux chips
    MCP3008ClockPin = 4             # CLK: chip pin # 13
    MCP3008ControlPin = 17          # CS/SHDN: chip pin # 10
    MCP3008DInPin = 11              # DIN: chip pin 11 ("MOSI" in python package)
    SensorPowerPin = 22             # Don't keep sensors powered on all the time
    MaxMoisture = 0                 # moisture scale inverted, as it is the raw resistance level from sensor
    MinMoisture = 1023

    # relations
    belongs_to :tank
    has_many :moisture_readings
    has_many :crops

    # validations
    validates :name, presence: true
    validates :number, presence: true
    validates :number, uniqueness: true
    validates :valve_pin, presence: true
    validates :sensor_pin, presence: true
    validates :sensor_index, presence: true
    validates :sensor_index, inclusion: 0..7
    validates :sensor_index, uniqueness: {scope: :sensor_pin}
    validates :moisture_target, presence: true
    validate  :moisture_target_in_limits

    def moisture_target_in_limits           # NB moisture scale inverted
        if moisture_target > MinMoisture || moisture_target < MaxMoisture
            errors.add(:moisture_target, "must be in range #{MaxMoisture}-#{MinMoisture}")
        end
    end

    # scopes
#     scope :planted, -> { where("crop is not null and crop != ''") }
    scope :ascending, -> { order(number: :asc) }

    # class methods
    def planted?
        self.crops.map { |c| c.planted? }.include?(true)
    end

    def self.moisture_sensors_activate
#         RPi::GPIO.set_high Zone.sensor_power_pin
      `python app/misc/python/set_pin_high.py #{Zone::SensorPowerPin}`
      p "Activating moisture sensors on GPIO pin #{Zone::SensorPowerPin}"
    end

    def self.moisture_sensors_deactivate
#         RPi::GPIO.set_low Zone.sensor_power_pin
      `python app/misc/python/set_pin_low.py #{Zone::SensorPowerPin}`
      p "Deactivating moisture sensors on GPIO pin #{Zone::SensorPowerPin}"
    end

    # instance methods
    def take_reading
      # Use Rpi on pin = self.sensor_pin and self.sensor_index
      value = (`python app/misc/python/read_moisture_sensor.py #{Zone::MCP3008ClockPin} #{Zone::MCP3008ControlPin} #{Zone::MCP3008DInPin} #{self.sensor_pin} #{self.sensor_index}`).to_i
      p "Reading for #{self.number} (pin #{self.sensor_pin}, index #{self.sensor_index}) is #{value}"
      self.moisture_readings.create(value: value)
    end

    def latest_reading
        self.moisture_readings.descending.first.present? ? self.moisture_readings.descending.first.value : MinMoisture
    end

    def crop_list
        self.crops.map{ |c| c.planted? ? c.name : nil } * ', '
    end

    def needs_water
        (self.latest_reading > self.moisture_target) && self.planted?
    end

    def valve_open
#         RPi::GPIO.set_high self.valve_pin
      `python app/misc/python/set_pin_high.py #{self.valve_pin}`
      p "Opening valve for zone #{self.number}"
    end

    def valve_close
#         RPi::GPIO.set_low self.valve_pin
      `python app/misc/python/set_pin_low.py #{self.valve_pin}`
      p "Closing valve for zone #{self.number}"
    end

    # Callbacks
    after_save do
#         RPi::GPIO.setup self.valve_pin, :as => :output
#         RPi::GPIO.setup self.sensor_pin, :as => :input
    end
end

