
#
# Copyright 2022 John C. Feltz, github: Feltz-UD-EE/garden_1
#
# Moisture sensors, used to determine when to turn on drip irrigation
#

class MoistureSensor < Sensor
    # statics & enums

    # relations
    belongs_to: sensor          # inheritance
    belongs_to: zone

    # validations

    # scopes

    # methods

end
