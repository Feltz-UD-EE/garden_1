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
    def self.summarize_and_prune_previous_years!(as_of: Date.current, max_days: 7, sleep_seconds: 0.25)
        summarize_and_prune_before!(
            cutoff_day: as_of.to_date.beginning_of_year,
            max_days: max_days,
            sleep_seconds: sleep_seconds
        )
    end

    def self.catch_up_previous_year_summaries!(as_of: Date.current, max_runtime: 30.minutes, sleep_seconds: 1.0)
        cutoff_day = as_of.to_date.beginning_of_year
        deadline = Time.current + max_runtime
        summarized_days = 0

        while Time.current < deadline
            count = summarize_and_prune_before!(
                cutoff_day: cutoff_day,
                max_days: 1,
                sleep_seconds: 0
            )

            break if count == 0

            summarized_days += count
            sleep sleep_seconds if sleep_seconds.to_f.positive?
        end

        summarized_days
    end

    def self.summarize_and_prune_before!(cutoff_day:, max_days: 7, sleep_seconds: 0.25)
        cutoff_day = cutoff_day.to_date
        oldest_day = where("created_at < ?", cutoff_day.beginning_of_day).minimum(:created_at)&.to_date
        return 0 unless oldest_day.present?

        summarized_days = 0
        (oldest_day...cutoff_day).first(max_days).each do |day|
            summarize_and_prune_day!(day)
            summarized_days += 1
            sleep sleep_seconds if sleep_seconds.to_f.positive?
        end

        summarized_days
    end

    def self.summarize_and_prune_day!(day)
        day = day.to_date
        day_range = day.beginning_of_day...day.next_day.beginning_of_day

        transaction do
            where(created_at: day_range)
                .select(
                    "zone_id",
                    "COUNT(*) AS readings_count",
                    "MIN(value) AS min_value",
                    "MAX(value) AS max_value",
                    "AVG(value) AS avg_value",
                    "SUM(value * value) AS sum_squares",
                    "MIN(created_at) AS first_reading_at",
                    "MAX(created_at) AS last_reading_at"
                )
                .group("zone_id")
                .each do |row|
                    summarize_day_for_zone!(day, row)
                end

            where(created_at: day_range).delete_all
        end
    end

    def self.summarize_day_for_zone!(day, row)
        count = row.readings_count.to_i
        avg = row.avg_value.to_f
        variance = count > 1 ? (row.sum_squares.to_f / count) - (avg * avg) : 0.0
        stddev = Math.sqrt([variance, 0.0].max)
        lower_2_sigma = avg - (2.0 * stddev)
        upper_2_sigma = avg + (2.0 * stddev)

        day_scope = where(
            zone_id: row.zone_id,
            created_at: day.beginning_of_day...day.next_day.beginning_of_day
        )

        summary = MoistureReadingDailySummary.find_or_initialize_by(
            zone_id: row.zone_id,
            day: day
        )

        summary.update!(
            readings_count: count,
            min_value: row.min_value,
            max_value: row.max_value,
            avg_value: avg,
            stddev_value: stddev,
            lower_2_sigma: lower_2_sigma,
            upper_2_sigma: upper_2_sigma,
            low_tail_count: day_scope.where("value < ?", lower_2_sigma).count,
            high_tail_count: day_scope.where("value > ?", upper_2_sigma).count,
            first_reading_at: row.first_reading_at,
            last_reading_at: row.last_reading_at
        )

        summary.crops = summary.zone.crops_on(day)
    end

    # instance methods

end
