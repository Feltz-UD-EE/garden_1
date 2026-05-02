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
    @old_moisture_readings_count = MoistureReading.where("created_at < ?", 1.year.ago.to_date.beginning_of_day).count
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
end
