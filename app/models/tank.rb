#
# Copyright 2022 John C. Feltz, github: Feltz-UD-EE/garden_1
#
# Tanks, aka rain barrels, which store water for distribution to drip irrigation lines
#
class Tank < ApplicationRecord
    # statics & enums
#     def self.LEVEL_SENSOR_LOCATIONS
#         {1: "low", 2: "mid", 3: "high"}
#     end

    # relations
    has_many: zones
    has_one: pump
    has_many: sensors, :through :zones

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
