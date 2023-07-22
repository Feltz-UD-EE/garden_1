#
# Copyright 2022 John C. Feltz, github: Feltz-UD-EE/garden_1
#
# Tanks: sources of water
#
class TanksController < ApplicationController
  before_action :set_tank, only: %i[ show edit update destroy ]

  # GET /tanks or /tanks.json
  def index
    @tanks = Tank.all
  end

  # GET /tanks/1 or /tanks/1.json
  def show
  end

  # GET /tanks/new
  def new
    rodauth.require_authentication
    @tank = Tank.new
  end

  # GET /tanks/1/edit
  def edit
    rodauth.require_authentication
  end

  # POST /tanks or /tanks.json
  def create
    rodauth.require_authentication
    @tank = Tank.new(tank_params)

    respond_to do |format|
      if @tank.save
        format.html { redirect_to public_home_path, notice: "Tank was successfully created." }
        format.json { render :show, status: :created, location: @tank }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tank.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tanks/1 or /tanks/1.json
  def update
    rodauth.require_authentication
    respond_to do |format|
      if @tank.update(tank_params)
        format.html { redirect_to public_home_path, notice: "Tank was successfully updated." }
        format.json { render :show, status: :ok, location: @tank }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tank.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tanks/1 or /tanks/1.json
  def destroy
    rodauth.require_authentication
    @tank.destroy

    respond_to do |format|
      format.html { redirect_to public_home_path, notice: "Tank was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tank
      @tank = Tank.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tank_params
      params.require(:tank).permit(:name, :volume, :pump_pin)
    end
end
