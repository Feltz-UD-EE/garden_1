#
# Copyright 2022 John C. Feltz, github: Feltz-UD-EE/garden_1
#
# Moisture Readings: most normal CRUD actions disabled because they are created through a cron
#   job and cannot be edited or deleted by the user
#
class MoistureReadingsController < ApplicationController
#   before_action :set_tank, only: %i[ show edit update destroy ]

  # GET /moisture_readings or /moisture_readings.json
  def index
    @moisture_readings = MoistureReading.where("zone_id = #{params['zone_id']}")
    @moisture_readings_one_week = MoistureReading.last_week.where("zone_id = #{params['zone_id']}")
  end

  # GET /moisture_readings/1 or /moisture_readings/1.json
  def show
  end

  # GET /moisture_readings/new
  # disable - moisture readings created only w/ cron job
  def new
  end

  # GET /moisture_readings/1/edit
  # disable - moisture readings not editable
  def edit
  end

  # POST /moisture_readings or /moisture_readings.json
  # disable - moisture readings created only w/ cron job
  def create
  end

  # PATCH/PUT /moisture_readings/1 or /moisture_readings/1.json
  # disable - moisture readings not editable
  def update
  end

  # DELETE /moisture_readings/1 or /moisture_readings/1.json
  # disable - moisture readings not deletable
  def destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_moisture_reading
      @moisture_reading = MoistureReading.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def moisture_reading_params
      params.fetch(:moisture_reading, {})
    end
end
