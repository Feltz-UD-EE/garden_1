#
# Copyright 2022 John C. Feltz, github: Feltz-UD-EE/garden_1
#
# Tanks: sources of water
#

class Tank < ApplicationRecord
    # statics & enums

    # relations
    has_many: zones

    # validations
    validates :name, presence: true
    validates :pump_pin, presence: true

    # scopes

    # class methods

    # instance methods

end
