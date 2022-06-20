#
# Copyright 2022 John C. Feltz, github: Feltz-UD-EE/garden_1
#
# Moisture Reading: historical reading of soil moisture level for a zone
#   * sensors return 0-1023 after going through A/D converter
#   * read-only from perspective of UI
#

class MoistureReading < ApplicationRecord
    # statics & enums

    # relations
    belongs_to :zone

    # validations

    # scopes
    scope :descending, -> { order(created_at: :desc) }

    # class methods

    # instance methods

end
