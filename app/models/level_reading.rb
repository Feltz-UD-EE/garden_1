#
# Copyright 2022-2023 John C. Feltz, github: Feltz-UD-EE/garden_1
#
# Level Reading: historical reading of water levels for a tank
#   * sensors nominally return binary signal, but will use A/D converter
#     because experiments show return voltage only in 2-2.5V range
#   * some sensors have a DIP switch that can be set for (absence of water = true)
#     or (presence of water = true), others don't.  Will need to make sure they
#     are consistent.

class LevelReading < ApplicationRecord
    # statics & enums

    # relations
    belongs_to :tank

    # validations

    # scopes
    scope :descending, -> { order(created_at: :desc) }
    scope :last_day, -> { where("created_at >= ?", Date.yesterday) }
    scope :last_week, -> { where("created_at >= ?", Date.today - 7.days)}

    # class methods

    # instance methods

end
