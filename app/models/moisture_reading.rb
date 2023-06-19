#
# Copyright 2022 John C. Feltz, github: Feltz-UD-EE/garden_1
#
# Moisture Reading: historical reading of soil moisture level for a zone
#   * sensors return 0-1023 after going through A/D converter
#   * read-only from perspective of UI
#
#      t.references :tank
#      t.boolean :low             # binary sensors

class MoistureReading < ApplicationRecord
    # statics & enums

    # relations
    belongs_to :zone

    # validations

    # scopes
    scope :descending, -> { order(created_at: :desc) }
    scope :last_day, -> { where("created_at >= ?", Date.yesterday) }
    scope :last_week, -> { where("created_at >= ?", Date.today - 7.days)}
    # class methods

    # instance methods

end
