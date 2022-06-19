#
# Copyright 2022 John C. Feltz, github: Feltz-UD-EE/garden_1
#
# Moisture sensors, used to determine when to turn on drip irrigation
#

class MoistureSensor < ApplicationRecord
    # statics & enums

    # relations
    belongs_to: zone

    # validations

    # scopes

    # methods

end
