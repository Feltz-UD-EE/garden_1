#
# Copyright 2022-2023 John C. Feltz, github: Feltz-UD-EE/garden_1
#
# Crops
#
class CropsController < ApplicationController
  before_action :set_crop, only: %i[ show edit update ]

  # GET /crops or /crops.json
  def index
    @crops = Crop.all.ascending
  end

  # GET /crops/1 or /crops/1.json
  def show
  end

  # GET /crops/new
  def new
    rodauth.require_authentication
    @crop = Crop.new(zone_id: params["zone_id"])
  end

  # GET /crops/1/edit
  def edit
    rodauth.require_authentication
  end

  # POST /crops or /crops.json
  def create
    rodauth.require_authentication
    @crop = Crop.new(crop_params)

    respond_to do |format|
      if @crop.save
        format.html { redirect_to crop_url(@crop), notice: "Crop was successfully created." }
        format.json { render :show, status: :created, location: @crop }
      else
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
        format.html { redirect_to crop_url(@crop), notice: "Crop was successfully updated." }
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
      format.html { redirect_to crops_url, notice: "Crop was successfully destroyed." }
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
      params.require(:crop).permit(:name, :description, :zone_id, :plant_date, :pull_date)
    end
end
