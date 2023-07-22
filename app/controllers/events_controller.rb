#
# Copyright 2022-2023 John C. Feltz, github: Feltz-UD-EE/garden_1
#
# Events
#
class EventsController < ApplicationController
  before_action :set_event, only: %i[ show edit update ]

  # GET /events or /events.json
  def index
    @events = Event.all.ascending
  end

  # GET /events/1 or /events/1.json
  def show
  end

  # GET /events/new
  def new
    rodauth.require_authentication
    p "trying to start create of new event. params = "
    p params
    @crop = Crop.find(params["crop_id"])
    @event = Event.new(crop_id: params["crop_id"], date: Date.today)
  end

  # GET /events/1/edit
  def edit
    rodauth.require_authentication
  end

  # POST /events or /events.json
  def create
    rodauth.require_authentication
    p "saving new event. event_params = "
    p event_params
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to event_url(@event), notice: "Event was successfully created." }
        format.json { render :show, status: :created, location: @event }
      else
        @crop = Crop.find(event_params["crop_id"])
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    rodauth.require_authentication
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to event_url(@event), notice: "Event was successfully updated." }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    rodauth.require_authentication
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url, notice: "Event was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:date, :description, :crop_id, :harvest)
    end
end
