#
# Copyright 2022-2023 John C. Feltz, github: Feltz-UD-EE/garden_1
#
# Zones: planted areas
#
class ZonesController < ApplicationController
  before_action :set_zone, only: %i[ show edit update destroy ]

  # GET /zones or /zones.json
  def index
    @zones = Zone.all.ascending
  end

  # GET /zones/1 or /zones/1.json
  def show
  end

  # GET /zones/new
  def new
    rodauth.require_authentication
    @zone = Zone.new(tank_id: params["tank_id"])
  end

  # GET /zones/1/edit
  def edit
    rodauth.require_authentication
  end

  # POST /zones or /zones.json
  def create
    rodauth.require_authentication
    @zone = Zone.new(zone_params)

    respond_to do |format|
      if @zone.save
        format.html { redirect_to tank_url(@zone.tank_id), notice: "Zone was successfully created." }
        format.json { render :show, status: :created, location: @zone }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @zone.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /zones/1 or /zones/1.json
  def update
    rodauth.require_authentication
    respond_to do |format|
      if @zone.update(zone_params)
        format.html { redirect_to tank_url(@zone.tank_id), notice: "Zone was successfully updated." }
        format.json { render :show, status: :ok, location: @zone }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @zone.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /zones/1 or /zones/1.json
  def destroy
    rodauth.require_authentication
    @zone.destroy

    respond_to do |format|
      format.html { redirect_to tank_url(@zone.tank_id), notice: "Zone was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_zone
      @zone = Zone.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def zone_params
      params.require(:zone).permit(:name, :number, :tank_id, :description, :valve_pin, :sensor_pin, :sensor_index, :moisture_target)
    end
end
