#
# Copyright 2026 John C. Feltz, github: Feltz-UD-EE/garden_1
#
# Moisture Reading Daily Summary: compact historical summary of moisture
# readings for a single zone on a single day.
#

class MoistureReadingDailySummary < ApplicationRecord
    # relations
    belongs_to :zone
    has_many :moisture_reading_daily_summary_crops, dependent: :destroy
    has_many :crops, through: :moisture_reading_daily_summary_crops

    # validations
    validates :zone_id, presence: true
    validates :day, presence: true
    validates :day, uniqueness: { scope: :zone_id }
    validates :readings_count, numericality: { greater_than_or_equal_to: 0 }
    validates :low_tail_count, numericality: { greater_than_or_equal_to: 0 }
    validates :high_tail_count, numericality: { greater_than_or_equal_to: 0 }

    # scopes
    scope :recent, -> { order(day: :desc) }
    scope :for_zone, ->(zone) { where(zone: zone) }
end
