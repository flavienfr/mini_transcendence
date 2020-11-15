class AskForGamesController < ApplicationController
  before_action :set_ask_for_game, only: [:show, :edit, :update, :destroy]

  # GET /ask_for_games
  # GET /ask_for_games.json
  def index
    if (params[:to_user_id])
      @game = AskForGame.where("to_user_id = ? AND status='playing'", params[:to_user_id]).last 
    elsif  (params[:from_user_id])
      @game = AskForGame.where("from_user_id = ? AND status='playing'", params[:from_user_id]).last
    else
       @game = AskForGame.all
    end
    respond_to do |format|
      format.html
      format.json {render json: @game}
    end
    #@ask_for_games = AskForGame.all
  end

  # GET /ask_for_games/1
  # GET /ask_for_games/1.json
  def show
  end

  # GET /ask_for_games/new
  def new
    @ask_for_game = AskForGame.new
  end

  # GET /ask_for_games/1/edit
  def edit
  end

  # POST /ask_for_games
  # POST /ask_for_games.json
  def create
	puts "------ POST /game_participations ---------"

	#gestion duel amicale TMP WTF
	#if (params[:type] == "duel")
	#	puts "--------- duel ---------"
	#	@ask_for_game = AskForGame.new(ask_for_game_params)
	#	respond_to do |format|
	#	  if @ask_for_game.save
	#		format.html { redirect_to @ask_for_game, notice: 'Ask for game was successfully created.' }
	#		format.json { render :show, status: :created, location: @ask_for_game }
	#	  else
	#		format.html { render :new }
	#		format.json { render json: @ask_for_game.errors, status: :unprocessable_entity }
	#	  end
	#	end
	#	return
	#end

	#Variable utils
	json_render = {}
	user = User.find(params[:from_user_id].to_i)
	if (params[:type] == "war_duel" || params[:type] == "war_random_match")
			#Variable utils
			guild_a = user.guild_participations.first.guild
			warp_a = WarParticipation.find(guild_a.war_participation_id)
			the_war = guild_a.wars.where('wars.status=?', "ongoing").first
			warp_b = WarParticipation.all.where('war_id=? AND guild_id!=?',the_war.id, guild_a.id).first
			guild_b = Guild.find(warp_b.guild_id)
			wartime = WarTime.all.where('war_id=?', the_war.id).first
	end

	if (params[:type] == "war_duel")
		puts "------ war_duel --------"
		to_user = User.find(params[:to_user_id].to_i)
		#CHECK: is in war

		@ask_for_game = AskForGame.new(
			from_user_id: user.id,
			to_user_id: to_user.id,
			game_type: "war_duel",
			status: "pending"
		)
		@ask_for_game.save

		msg = "War duel match by " + user.name + " from " + guild_a.name + "."
		send_notification(user.id, to_user.id, "ask_for_game", @ask_for_game.id, msg, "pending")

		json_render["msg"] = "War duel sent to " + to_user.name + "."
		json_render["is_msg"] = 1
		render json: json_render, status: :ok and return

	elsif (params[:type] == "war_random_match")
		puts "------ war_random_match -------"

	 	#Ask_for_games creation to delete afet acceptation ou after delay
	 	@ask_for_game = AskForGame.new(
	 		from_user_id: user.id,
	 		to_user_id: nil,
	 		game_type: "war_random_match",
	 		status: "pending"
	 	)
	 	@ask_for_game.save

		#Check is war time
		puts "--------------wartime: " + wartime.to_json
		if (wartime != nil && wartime.start_date.to_s < Time.zone.now.to_s && wartime.end_date.to_s > Time.zone.now.to_s)
			if (wartime.ongoing_match == true)
				json_render["msg"] = "A war time match is ongoing.\nYou can have only one war time match at the time."
				json_render["is_msg"] = 1
				render json: json_render, status: :ok and return
			end
			#TODO: lancé le delay qui après un certain temps upadate war time (si atteint max unanswerd match fin du war time ?)

			#Send notif to all opponent guild
			for to_user in guild_b.users do
				puts "--- Notification sent to user: " + user.name
				msg = "War Random match by " + user.name + " from " + guild_a.name + ".\n You have n minutes to accept."
				send_notification(user.id, to_user.id, "ask_for_game", @ask_for_game.id, msg, "pending")
			end
			json_render["msg"] = "Random duel sent to all players of " + guild_b.name + ".\nFor a duration of n minutes."
			json_render["is_msg"] = 1
			render json: json_render, status: :ok and return
		else
			json_render["msg"] = "There is no war time currently.\nYou can ask for random fight only during war time."
			json_render["is_msg"] = 1
			render json: json_render, status: :ok and return
		end
	elsif (params[:type] == "ladder_match_making")
		puts "------ ladder_match_making ---------"
	else
		puts "------ error type --------=> " + params[:type].to_s
	end
  end

  # PATCH/PUT /ask_for_games/1
  # PATCH/PUT /ask_for_games/1.json
  def update
	puts "--------- PATCH/PUT /ask_for_games/1 --------"
	#Variable utils
	json_render = {}
	
	if (@ask_for_game.game_type == "war_random_match" || @ask_for_game.game_type == "war_duel")
		puts "------------@ask_for_game.status: " + @ask_for_game.status 
		#TODO:	Ajouté check du delay
		#		check is in war time
		#		update status war_time ici et en fin de match
		if (@ask_for_game.status == "pending")
			@ask_for_game.update(
				to_user_id: params[:user_id],
				status: "playing"
			)
			json_render["msg"] = "LANCÉ LE MATCH"
			json_render["is_msg"] = true
			json_render["error"] = false
			json_render["ask_for_game"] = @ask_for_game
			render json: json_render, status: :ok and return
		else
			json_render["msg"] = "Match already accept by an other player."
			json_render["is_msg"] = true
			json_render["error"] = true
			render json: json_render, status: :ok and return
		end
	end
  end

  # DELETE /ask_for_games/1
  # DELETE /ask_for_games/1.json
  def destroy
	#detruire war time ask for game quand delay est passé 
    @ask_for_game.destroy
    respond_to do |format|
      format.html { redirect_to ask_for_games_url, notice: 'Ask for game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ask_for_game
      @ask_for_game = AskForGame.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ask_for_game_params
      params.require(:ask_for_game).permit(:from_user_id, :to_user_id, :status)
	end
	
	def send_notification(from_user_id, to_user_id, table_type, table_id, message, status)
		@notification = Notification.new(
		  from_user_id: from_user_id,
		  user_id: to_user_id,
		  table_type: table_type,
		  table_id: table_id,
		  message: message,
		  status: status
		)
		puts "----- notification ----"
		puts @notification.to_json
		puts "-----------------------"

		@notification.save
		notif_channel = "notification_channel_" + to_user_id.to_s;
		ActionCable.server.broadcast(notif_channel, {notification: "On"})
	end

end
