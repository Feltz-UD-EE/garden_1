#
# Copyright 2026 John C. Feltz, github: Feltz-UD-EE/garden_1
#
#
# Summarize completed calendar years of moisture readings into compact daily
# zone summaries, then prune the raw readings.
#
class MoistureReadingSummariesJob < ActiveJob::Base
  DEFAULT_MAX_DAYS = 7
  DEFAULT_MAX_RUNTIME = 30.minutes
  DEFAULT_SLEEP_SECONDS = 0.5

  def perform(as_of: Date.current, max_days: DEFAULT_MAX_DAYS, sleep_seconds: DEFAULT_SLEEP_SECONDS)
    p "About to run MoistureReadingSummariesJob"
    p "Summarizing moisture readings before #{as_of.to_date.beginning_of_year}"

    summarized_days = MoistureReading.summarize_and_prune_previous_years!(
      as_of: as_of,
      max_days: max_days,
      sleep_seconds: sleep_seconds
    )

    p "MoistureReadingSummariesJob summarized #{summarized_days} day#{'s' unless summarized_days == 1}"
    summarized_days
  end

  def self.catch_up(as_of: Date.current, max_runtime: DEFAULT_MAX_RUNTIME, sleep_seconds: DEFAULT_SLEEP_SECONDS)
    p "About to run MoistureReadingSummariesJob catch-up"
    p "Catch-up will summarize moisture readings before #{as_of.to_date.beginning_of_year}"

    summarized_days = MoistureReading.catch_up_previous_year_summaries!(
      as_of: as_of,
      max_runtime: max_runtime,
      sleep_seconds: sleep_seconds
    )

    p "MoistureReadingSummariesJob catch-up summarized #{summarized_days} day#{'s' unless summarized_days == 1}"
    summarized_days
  end
end
