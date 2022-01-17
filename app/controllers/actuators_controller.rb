class ActuatorsController < ApplicationController
  before_action :set_actuator, only: %i[ show edit update destroy ]

  # GET /actuators or /actuators.json
  def index
    @actuators = Actuator.all
  end

  # GET /actuators/1 or /actuators/1.json
  def show
  end

  # GET /actuators/new
  def new
    @actuator = Actuator.new
  end

  # GET /actuators/1/edit
  def edit
  end

  # POST /actuators or /actuators.json
  def create
    @actuator = Actuator.new(actuator_params)

    respond_to do |format|
      if @actuator.save
        format.html { redirect_to actuator_url(@actuator), notice: "Actuator was successfully created." }
        format.json { render :show, status: :created, location: @actuator }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @actuator.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /actuators/1 or /actuators/1.json
  def update
    respond_to do |format|
      if @actuator.update(actuator_params)
        format.html { redirect_to actuator_url(@actuator), notice: "Actuator was successfully updated." }
        format.json { render :show, status: :ok, location: @actuator }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @actuator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /actuators/1 or /actuators/1.json
  def destroy
    @actuator.destroy

    respond_to do |format|
      format.html { redirect_to actuators_url, notice: "Actuator was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_actuator
      @actuator = Actuator.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def actuator_params
      params.fetch(:actuator, {})
    end
end
