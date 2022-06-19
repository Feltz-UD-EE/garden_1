#
# Copyright 2022 John C. Feltz, github: Feltz-UD-EE/garden_1
#
# Water level sensors, used in rain barrels to determine when to transfer water
#   and whether to generate low-water alerts
#

class LevelSensor < ApplicationRecord
    # statics & enums
    def self.LEVEL_SENSOR_LOCATIONS
        {1: "low", 2: "mid", 3: "high"}
    end

    # relations
    belongs_to: tank

    # validations
    validates :position, presence: true
    validates :position, inclusion: { in: self.LEVEL_SENSOR_LOCATIONS.keys,
        message: "%{value} is not in the range %{self.LEVEL_SENSOR_LOCATIONS.keys}"}

    # scopes

    # methods
    def verbal_position
        LEVEL_SENSOR_LOCATIONS[position]
    end

end
