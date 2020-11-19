class TournamentParticipationsController < ApplicationController
  before_action :set_tournament_participation, only: [:show, :edit, :update, :destroy]

  # GET /tournament_participations
  # GET /tournament_participations.json
  def index
    @tournament_participations = TournamentParticipation.all
    if (params[:type] == "all_in")
      tournamentP = TournamentParticipation.where("user_id = ?", params[:user_id]);
      to_return_json = {};
      tournamentP.each do |participation|
        to_return_json[participation.tournament_id] = participation;
      end
      respond_to do |format|
        format.html
        format.json {render json: to_return_json}
      end
    end
  end

  # GET /tournament_participations/1
  # GET /tournament_participations/1.json
  def show
  end

  # GET /tournament_participations/new
  def new
    @tournament_participation = TournamentParticipation.new
  end

  # GET /tournament_participations/1/edit
  def edit
  end

  # POST /tournament_participations
  # POST /tournament_participations.json
  def create
    @tournament_participation = TournamentParticipation.new(tournament_participation_params)

    respond_to do |format|
      if @tournament_participation.save
        format.html { redirect_to @tournament_participation, notice: 'Tournament participation was successfully created.' }
        format.json { render :show, status: :created, location: @tournament_participation }
      else
        format.html { render :new }
        format.json { render json: @tournament_participation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tournament_participations/1
  # PATCH/PUT /tournament_participations/1.json
  def update
    respond_to do |format|
      if @tournament_participation.update(tournament_participation_params)
        format.html { redirect_to @tournament_participation, notice: 'Tournament participation was successfully updated.' }
        format.json { render :show, status: :ok, location: @tournament_participation }
      else
        format.html { render :edit }
        format.json { render json: @tournament_participation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tournament_participations/1
  # DELETE /tournament_participations/1.json
  def destroy
    @tournament_participation.destroy
    respond_to do |format|
      format.html { redirect_to tournament_participations_url, notice: 'Tournament participation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tournament_participation
      @tournament_participation = TournamentParticipation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tournament_participation_params
      params.require(:tournament_participation).permit(:user_id, :tournament_id, :status, :score, :nb_won_game, :nb_lose_game)
    end
end
