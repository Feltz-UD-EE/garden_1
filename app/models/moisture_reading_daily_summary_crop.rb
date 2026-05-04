#
# Copyright 2026 John C. Feltz, github: Feltz-UD-EE/garden_1
#
# Moisture Reading Daily Summary Crop: preserves which crop or crops were in a
# zone when a compact moisture summary was created.
#

class MoistureReadingDailySummaryCrop < ApplicationRecord
    # relations
    belongs_to :moisture_reading_daily_summary
    belongs_to :crop

    # validations
    validates :moisture_reading_daily_summary_id, uniqueness: { scope: :crop_id }
end
