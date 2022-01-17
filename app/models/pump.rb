#
# Copyright 2022 John C. Feltz, github: Feltz-UD-EE/garden_1
#
# Pumps, used with rain barrels to either transfer water or to pressure drip irrigation lines
#

class Pump < Actuator
    # statics & enums

    # relations
    belongs_to: actuator          # inheritance
    belongs_to: tank

    # validations

    # scopes

    # methods

end
