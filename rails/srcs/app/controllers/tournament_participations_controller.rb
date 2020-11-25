class TournamentParticipationsController < ApplicationController
  before_action :set_tournament_participation, only: [:show, :edit, :update, :destroy]

  # GET /tournament_participations
  # GET /tournament_participations.json
  def index
    @tournament_participations = TournamentParticipation.all
    puts "----------------------------------"
    puts params
    puts "///////////////////////////////////"
    if (params[:type] == "user_participation")
      puts "here"
      @participation = TournamentParticipation.where("user_id = ? AND tournament_id = ?", params[:user_id], params[:tournament_id]).first
      puts @participation
      respond_to do |format|
        format.html
        format.json {render json: @participation}
      end
    elsif (params[:type] == "all_in")
      tournamentP = TournamentParticipation.where("user_id = ?", params[:user_id]);
      puts tournamentP.to_json;
      user_tournament_participations = {};
      tournamentP.each do |participation|
        user_tournament_participations[participation.tournament_id] = participation;
      end
      tournament_nb_player_ordered = {};
      Tournament.all.each do |tournament|
        tournament_nb_player_ordered[tournament.id] = TournamentParticipation.where("tournament_id = ?", tournament.id).size;
      end
      to_return_json = {};
      to_return_json["user_tournament_participations"] = user_tournament_participations;
      to_return_json["tournament_nb_player_ordered"] = tournament_nb_player_ordered;
      respond_to do |format|
        format.html
        format.json {render json: to_return_json}
      end
    elsif (params[:type] == "all_participants")
      users_in_order = {};
      User.all.each do |user|
        users_in_order[user.id] = user.name;
      end
      participations = TournamentParticipation.where("tournament_id = ?", params[:tournament_id]).order("created_at");
      to_return_json = {};
      to_return_json["participations"] = participations;
      to_return_json["users"] = users_in_order;
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
    puts "????????????????????"
    puts params;
    tournament_participations = TournamentParticipation.where("user_id = ?", params[:user_id]);
    puts params;
    tournament_participations.each do |participation|
      if (participation.tournament.status == 'created' || participation.tournament.status == 'started')
        respond_to do |format|
          format.html
          format.json {render json: {error_text: "you_cant_be_subscribed_in_2_tournaments"}, status: :unprocessable_entity}
        end
        return;
      end
    end
    # @tournament_participation = TournamentParticipation.new(tournament_participation_params)
    tournament = Tournament.find_by(id: params[:tournament_id]);
    start_time = tournament.deadline;
    if (Time.now > start_time - 0.minute)# change time a decommenter
     respond_to do |format|
       format.html
       format.json {render json: {error_text: "too_late_to_register"}, status: :unprocessable_entity}
     end
     return;
    end

    @tournament_participation = TournamentParticipation.where("tournament_id = ?", params[:tournament_id]);

    if (@tournament_participation.size >= Tournament.find_by(id: params[:tournament_id]).max_nb_player)
      respond_to do |format|
        format.html {render :new}
        format.json {render json: {error_text: "max_nb_of_players_reached"}, status: :unprocessable_entity}
      end
      return;
    end

    @tournament_participation = TournamentParticipation.new(tournament_participation_params)

    respond_to do |format|
      if @tournament_participation.save
        send_notification(params[:user_id], params[:user_id], "information", nil, "you registered in a tournament", nil);
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
    puts params
    respond_to do |format|
      if @tournament_participation.update(tournament_participation_params)
        format.html { redirect_to @tournament_participation, notice: 'Tournament participation was successfully updated.' }
        format.json { render :show, status: :ok, location: @tournament_participation }
      else
        format.html { render :edit }
        format.json { render json: @tournament_participation.errors, status: :unprocessable_entity }
      end
    end
    if (params[:type] == "update_tournament_win")
      tournament = TournamentParticipation.find(params[:id]).tournament;
      puts tournament.to_json;
      if (tournament.max_nb_player == 1)
        User.all.each do |user|
          ActionCable.server.broadcast("notification_channel_" + user.id.to_s, {refresh_tournament_details_id: tournament.id});
        end
        tournament.update(status: "ended");
        winner = TournamentParticipation.where("nb_won_game = ? AND tournament_id = ?", tournament.step, tournament.id).first;
        puts "winner = " + User.find(winner.user_id).name.to_s;
        puts "end of tournament !"
        return ;
      end
      participations = TournamentParticipation.where("nb_won_game = ? AND tournament_id = ?", tournament.step, tournament.id).order("created_at");
      puts participations.to_json;
      if (participations.size == tournament.max_nb_player)
        User.all.each do |user|
          ActionCable.server.broadcast("notification_channel_" + user.id.to_s, {refresh_tournament_details_id: tournament.id});
        end
        i = 0;
        j = 0;
        nb_player = tournament.max_nb_player
        tournament.update(max_nb_player: tournament.max_nb_player / 2);
        tournament.update(step: tournament.step + 1);
        while ( i < (nb_player / 2))
          game = Game.create(tournament_id:  tournament.id);
          gameP1 = GameParticipation.create(user_id: participations[j].user_id, game_id: game.id);
          gameP2 = GameParticipation.create(user_id: participations[j + 1].user_id, game_id: game.id);
          if (participations.first.is_already_playing(participations.first, participations[j].user_id,participations[j + 1].user_id, game) == false)
            AskForGame.create(from_user_id: participations[j].user_id, to_user_id: participations[j + 1].user_id, status: "playing", game_type: "Tournament", game_id: game.id);
            ActionCable.server.broadcast("notification_channel_" + participations[j].user_id.to_s, {game: "on", content: "host_user"});
            ActionCable.server.broadcast("notification_channel_" + participations[j + 1].user_id.to_s, {game: "on", content: "guest_user", host_id: participations[j].user_id});
          end
          j = j + 2;  
          i = i + 1;
        end
        # tournament.update(max_nb_player: tournament.max_nb_player / 2);
        # tournament.update(step: tournament.step + 1);
      end
    end
    # puts params
    # respond_to do |format|
    #   if @tournament_participation.update(tournament_participation_params)
    #     format.html { redirect_to @tournament_participation, notice: 'Tournament participation was successfully updated.' }
    #     format.json { render :show, status: :ok, location: @tournament_participation }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @tournament_participation.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /tournament_participations/1
  # DELETE /tournament_participations/1.json
  def destroy
    tournament = Tournament.find_by(id: TournamentParticipation.find_by(id: params[:id]).tournament_id);
    start_time = tournament.deadline;
    if (Time.now > start_time - 15.minute)
      respond_to do |format|
        format.html
        format.json {render json: {error_text: "too_late_to_unregister"}, status: :unprocessable_entity}
      end
      return;
    end
    @tournament_participation.destroy
    send_notification(current_user.id, current_user.id, "information", nil, "you unregistered from a tournament", nil);
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
