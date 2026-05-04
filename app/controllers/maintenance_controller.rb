#
# Copyright 2026 John C. Feltz, github: Feltz-UD-EE/garden_1
#
# Maintenance: operational checks and storage-management entry points.
#
class MaintenanceController < ApplicationController
  before_action :require_login

  def index
    @zones = Zone.ascending
    @moisture_readings_count = MoistureReading.count
  end

  def sensors
    @zones = Zone.ascending
  end

  def data_retention
    @moisture_readings_count = MoistureReading.count
    @previous_year_moisture_readings_count =
      MoistureReading.where("created_at < ?", Date.current.beginning_of_year).count
    @moisture_summary_count = MoistureReadingDailySummary.count
    @moisture_summary_crop_count = MoistureReadingDailySummaryCrop.count
  end

  def summarize_moisture_readings
    summarized_days = MoistureReading.summarize_and_prune_previous_years!(
      max_days: summarize_moisture_readings_max_days,
      sleep_seconds: 0.5
    )

    redirect_to maintenance_data_retention_path,
                notice: "Summarized and pruned #{summarized_days} day#{'s' unless summarized_days == 1} of completed-year moisture readings."
  end

  def backups
  end

  def notes
    @notes = Note.descending.limit(50)
  end

  private

    def require_login
      rodauth.require_authentication
    end

    def summarize_moisture_readings_max_days
      max_days = params.fetch(:max_days, 3).to_i
      max_days.clamp(1, 30)
    end
end
