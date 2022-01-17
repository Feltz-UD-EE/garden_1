#
# Copyright 2022 John C. Feltz, github: Feltz-UD-EE/garden_1
#
# Sensor parent class; current subclasses are:
#   temperature_sensor
#   moisture_sensor
#   level_sensor
#

class Sensor < ApplicationRecord
    # statics & enums

    # relations
    has_one :level_sensor           # not sure these are right, need to read up on inheritance
    has_one :moisture_sensor
    has_one :temp_sensor
    belongs_to :pin

    # validations
    validates :pin_id, uniqueness: true
        # also need to cross-validate with pin_id for actuators eventually

    # scopes

    # methods

end
