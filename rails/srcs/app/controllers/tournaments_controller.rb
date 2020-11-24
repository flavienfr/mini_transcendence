class TournamentsController < ApplicationController
  before_action :set_tournament, only: [:show, :edit, :update, :destroy]

  # GET /tournaments
  # GET /tournaments.json
  def index
    @tournaments = Tournament.all
    respond_to do |format|
      format.html
      format.json {render json: @tournaments}
    end
  end

  # GET /tournaments/1
  # GET /tournaments/1.json
  def show
    if (params[:type] == "games_tournament_live")
      all_playing_ask_for_game = AskForGame.where("game_id IN (?) AND status = 'playing'", Tournament.find_by(id: params[:id]).games.pluck(:id));
      puts "-----"
      puts all_playing_ask_for_game.to_json;
      puts "-----"
      users_in_order = {};
      User.all.each do |user|
        users_in_order[user.id] = user.name;
      end
      to_return_json = {};
      to_return_json["ask_for_games"] = all_playing_ask_for_game;
      to_return_json["users"] = users_in_order;
      respond_to do |format|
        format.html
        format.json {render json: to_return_json}
      end
      return;
    end
    respond_to do |format|
      format.html
      format.json {render json: Tournament.find_by(id: params[:id])}
    end
  end

  # GET /tournaments/new
  def new
    @tournament = Tournament.new
  end

  # GET /tournaments/1/edit
  def edit
  end

  # POST /tournaments
  # POST /tournaments.json
  def create
    #puts params[:deadline].to_datetime - 15.minute;

    #a decommenter
    #if (Time.now > (params[:deadline].in_time_zone(Time.zone) - 15.minute))
    #  respond_to do |format|
    #    format.html
    #    format.json {render json: {error_text: "start_time_not_correct"}, status: :unprocessable_entity}
    #  end
    #  return;
    #end

    params[:tournament]["status"] = "created";
    @tournament = Tournament.new(tournament_params)

    #StartTournamentJob.set(wait: 1.minute).perform_later("hey");

    respond_to do |format|
      if @tournament.save
        StartTournamentJob.set(wait_until: @tournament.deadline).perform_later(@tournament);
        User.all.each do |user|
          send_notification(current_user.id, user.id, "information", nil, "new tournament available", nil);
        end
        format.html { redirect_to @tournament, notice: 'Tournament was successfully created.' }
        format.json { render :show, status: :created, location: @tournament }
      else
        format.html { render :new }
        format.json { render json: @tournament.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tournaments/1
  # PATCH/PUT /tournaments/1.json
  def update
    respond_to do |format|
      if @tournament.update(tournament_params)
        format.html { redirect_to @tournament, notice: 'Tournament was successfully updated.' }
        format.json { render :show, status: :ok, location: @tournament }
      else
        format.html { render :edit }
        format.json { render json: @tournament.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tournaments/1
  # DELETE /tournaments/1.json
  def destroy
    @tournament.destroy
    respond_to do |format|
      format.html { redirect_to tournaments_url, notice: 'Tournament was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tournament
      @tournament = Tournament.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tournament_params
      params.require(:tournament).permit(:rules, :incentives, :status, :deadline, :max_nb_player)
    end
end
