#
# Copyright 2022-2023 John C. Feltz, github: Feltz-UD-EE/garden_1
#
# Crops
#
class CropsController < ApplicationController
  before_action :set_crop, only: %i[ show edit update ]

  # GET /crops or /crops.json
  def index
    if params[:past].present? && params[:past] != 0
      @crops = Crop.last_year.alpha
      @harvests = []
      print(@crops)
      @crops.each do |crop|
        @harvests << crop.total_harvest_last_year
      end
      print(@harvests)
      render :past
    else                                        # 'normal' index
      @crops = Crop.this_year.alpha             # NB add get param for additional menu items
      render :index
    end
  end

  # GET /crops/1 or /crops/1.json
  def show
  end

  # GET /crops/new
  # Can only be called from a zone, hence redirect if no zone_id specified
  def new
    rodauth.require_authentication
    if !params["zone_id"].present?
      redirect_to public_home_path
    end
    @zone = Zone.find(params["zone_id"])
    @crop = Crop.new(zone_id: params["zone_id"], plant_date: Date.today)
  end

  # GET /crops/1/edit
  def edit
    rodauth.require_authentication
    @zone = @crop.zone
  end

  # POST /crops or /crops.json
  def create
    rodauth.require_authentication
    @crop = Crop.new(crop_params)

    respond_to do |format|
      if @crop.save
        format.html { redirect_to zone_url(@crop.zone_id), notice: "Crop was successfully created." }
        format.json { render :show, status: :created, location: @crop }
      else
        @zone = Zone.find(crop_params["zone_id"])
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @crop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /crops/1 or /crops/1.json
  def update
    rodauth.require_authentication
    respond_to do |format|
      if @crop.update(crop_params)
        format.html { redirect_to zone_url(@crop.zone_id), notice: "Crop was successfully updated." }
        format.json { render :show, status: :ok, location: @crop }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @crop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /crops/1 or /crops/1.json
  def destroy
    rodauth.require_authentication
    @crop.destroy

    respond_to do |format|
      format.html { redirect_to zone_url(@crop.zone_id), notice: "Crop was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # GET /crops/1/split
  def split
    rodauth.require_authentication
    crop = Crop.find(params["crop_id"])
    new_crop = crop.dup
    datestr = Time.zone.now.strftime("%Y-%m-%d")
    new_crop.name += " (split #{datestr})"
    crop.name += " (original; split on #{datestr})"
    crop.save
    new_crop.save
    crop.events.each do |event|
      new_event = event.dup
      new_event.crop_id = new_crop.id
      new_event.save
    end

    respond_to do |format|
      format.html { redirect_to zone_url(crop.zone_id), notice: "Crop was successfully split." }
      format.json { head :no_content }
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_crop
      @crop = Crop.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def crop_params
      params.require(:crop).permit(:name, :description, :season, :zone_id, :plant_date, :pull_date)
    end
end
