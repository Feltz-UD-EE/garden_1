#
# Copyright 2022 John C. Feltz, github: Feltz-UD-EE/garden_1
#
# Actuator parent class; current subclasses are:
#   pump
#   valve
#

class Actuator < ApplicationRecord
    # statics & enums

    # relations
    has_one :pump           # not sure these are right, need to read up on inheritance
    has_one :valve
    belongs_to :pin

    # validations
    validates :pin_id, uniqueness: true
        # also need to cross-validate with pin_id for sensors eventually

    # scopes

    # methods

end
