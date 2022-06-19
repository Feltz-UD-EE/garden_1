#
# Copyright 2022 John C. Feltz, github: Feltz-UD-EE/garden_1
#
# Zone: single area to be monitored and water, generally all the same crop.
#
class Zone < ApplicationRecord
    # statics & enums
#     def self.LEVEL_SENSOR_LOCATIONS
#         {1: "low", 2: "mid", 3: "high"}
#     end

    # relations
    has_one: moisture_sensor
    has_one: valve

    # validations
#     validates :position, presence: true
#     validates :position, inclusion: { in: self.LEVEL_SENSOR_LOCATIONS.keys,
#         message: "%{value} is not in the range %{self.LEVEL_SENSOR_LOCATIONS.keys}"}

    # scopes

    # methods
#     def verbal_position
#         LEVEL_SENSOR_LOCATIONS[position]
#     end



end
