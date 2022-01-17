#
# Copyright 2022 John C. Feltz, github: Feltz-UD-EE/garden_1
#
# Temperature sensors, not currently used in logic but stored for retrospective analysis
#
class TempSensor < Sensor
    # statics & enums
    def self.TEMP_SENSOR_LOCATIONS
        {1: "subsoil", 2: "surface", 3: "elevated"}
    end

    # relations
    belongs_to: sensor          # inheritance
    belongs_to: zone

    # validations
    validates :position, presence: true
    validates :position, inclusion: { in: self.TEMP_SENSOR_LOCATIONS.keys,
        message: "%{value} is not in the range %{self.TEMP_SENSOR_LOCATIONS.keys}"}

    # scopes

    # methods
    def verbal_position
        TEMP_SENSOR_LOCATIONS[position]
    end


end
