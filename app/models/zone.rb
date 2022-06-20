#
# Copyright 2022 John C. Feltz, github: Feltz-UD-EE/garden_1
#
# Zones: planted areas, usually 1 crop (or closely related plants)
#   * a zone is typically 1 or 2 rows, or half of a 4'x8' raised bed (~16 square feet, ~1.5 square meters)
#

class Zone < ApplicationRecord
    # statics & enums
    sensor_multiplex_clock_pin = 1
    sensor_multiplex_addressing_pin = 2
    max_moisture = 0
    min_moisture = 1023

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

    # scopes
    scope :planted, -> { where("crop IS NOT NULL") }

    # class methods

    # instance methods
    def latest_reading
        self.moisture_readings.descending.first.present? ? self.moisture_readings.descending.first.value : Zone.min_moisture
    end
    def needs_water
        self.latest_reading < self.moisture_target
    end
end

