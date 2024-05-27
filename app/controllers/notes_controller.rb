#
# Copyright 2022-2023 John C. Feltz, github: Feltz-UD-EE/garden_1
#
# Notes
#
class NotesController < ApplicationController
  before_action :set_event, only: %i[ show edit update ]

  # GET /notes or /notes.json
  def index
    @notes = Note.all.descending
  end

  # GET /notes/1 or /notes/1.json
  def show
  end

  # GET /notes/new
  def new
    rodauth.require_authentication
    @note = Note.new(date: Date.today)
  end

  # GET /notes/1/edit
  def edit
    rodauth.require_authentication
  end

  # POST /notes or /notes.json
  def create
    rodauth.require_authentication
    p "saving new note "
    @note = Note.new(note_params)

    respond_to do |format|
      if @note.save
        format.html { redirect_to public_home_path, notice: "Note was successfully created." }
        format.json { render :show, status: :created, location: @note }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notes/1 or /notes/1.json
  def update
    rodauth.require_authentication
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to public_home_path, notice: "Note was successfully updated." }
        format.json { render :show, status: :ok, location: @note }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1 or /notes/1.json
  def destroy
    rodauth.require_authentication
    @note.destroy

    respond_to do |format|
      format.html { redirect_to public_home_path, notice: "Note was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def note_params
      params.require(:note).permit(:date, :description)
    end
end
