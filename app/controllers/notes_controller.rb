class NotesController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :set_note, only: %i[ show edit update destroy ]

  # GET /notes or /notes.json
  def index
    @notes = Note.all
  end

  # GET /notes/1 or /notes/1.json
  def show
  end

  # GET /notes/new
  def new
    @note = Note.new
  end

  # GET /notes/1/edit
  def edit
  end

  # POST /notes or /notes.json
  def create
    @note = Note.new(description: note_params['description'])
    respond_to do |format|
      if @note.save
        format.json do
          render json: { noteId: @note.id, error: nil }
        end
      else
        format.json do
          render json: { error: @note.errors.full_messages }
        end
      end
    end
  end

  # PATCH/PUT /notes/1 or /notes/1.json
  def update
    puts 'in update'
    respond_to do |format|
      if @note.update(note_params)
        format.json { render json: { saved: 'ok' } }
      else
        format.json { render json: @note.errors }
      end
    end
  end

  # DELETE /notes/1 or /notes/1.json
  def destroy
    @note.destroy

    respond_to do |format|
      format.html { redirect_to notes_url, notice: "Note was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id]) if params[:id]
      @note ||= Note.new
    end

    # Only allow a list of trusted parameters through.
    def note_params
      params.require(:note).permit(:description, :patient_id, :doctor_id, :id)
    end
end
