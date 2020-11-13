class GameParticipationsController < ApplicationController
  before_action :set_game_participation, only: [:show, :edit, :update, :destroy]

  # GET /game_participations
  # GET /game_participations.json
  def index
    @game_participations = GameParticipation.all
  end

  # GET /game_participations/1
  # GET /game_participations/1.json
  def show
  end

  # GET /game_participations/new
  def new
    @game_participation = GameParticipation.new
  end

  # GET /game_participations/1/edit
  def edit
  end

  # POST /game_participations
  # POST /game_participations.json
  def create

  end

  # PATCH/PUT /game_participations/1
  # PATCH/PUT /game_participations/1.json
  def update
    respond_to do |format|
      if @game_participation.update(game_participation_params)
        format.html { redirect_to @game_participation, notice: 'Game participation was successfully updated.' }
        format.json { render :show, status: :ok, location: @game_participation }
      else
        format.html { render :edit }
        format.json { render json: @game_participation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /game_participations/1
  # DELETE /game_participations/1.json
  def destroy
    @game_participation.destroy
    respond_to do |format|
      format.html { redirect_to game_participations_url, notice: 'Game participation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game_participation
      @game_participation = GameParticipation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def game_participation_params
      params.require(:game_participation).permit(:user_id, :game_id, :score, :is_winner)
    end
end
