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
	puts params[:from_user_id].to_i
	puts params[:to_user_id].to_i
	puts params[:game_type]
	#----------- Variable utils ------------------- #
	json_render = {}
	# USER A
	user = User.find(params[:from_user_id].to_i)
	if (user.guild_participations.first != nil)
		guild_a = user.guild_participations.first.guild
	end
	if (guild_a != nil)
		war_a = guild_a.wars.where('wars.status=?', "ongoing").first
	end
	if (war_a != nil)
		wartime = WarTime.all.where('war_id=?', war_a.id).first
	end
	# USER B
	if (params[:game_type] != "war_random_match")
		to_user = User.find(params[:to_user_id].to_i)
		if (to_user.guild_participations.first != nil)
			guild_b = to_user.guild_participations.first.guild
		end
		war_b = nil
		if (guild_b != nil)
			war_b = guild_b.wars.where('wars.status=?', "ongoing").first
		end
	end
	#---------------------------------------------

	if (params[:game_type] == "war_duel" || params[:game_type] == "duel")
		if (user.id == to_user.id)
			json_render["msg"] = "You can't duel your self."
			json_render["is_msg"] = 1
			render json: json_render, status: :ok and return
		end
		if (AskForGame.where('status=? AND to_user_id=?', "pending", to_user.id).size > 0)
			json_render["msg"] = "An invitation to duel is already in progress with this player."
			json_render["is_msg"] = 1
			render json: json_render, status: :ok and return
		end
		if (war_a != nil && war_a.id == war_b.id && war_a.start_date.to_s < Time.zone.now.to_s && war_a.end_date.to_s > Time.zone.now.to_s)
			puts "------ war_duel --------"

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
		
		else
			puts "------ friendly_duel --------"

			@ask_for_game = AskForGame.new(
				from_user_id: user.id,
				to_user_id: to_user.id,
				game_type: "friendly_duel",
				status: "pending"
			)
			@ask_for_game.save

			msg = "Friendly duel match by " + user.name + "."
			send_notification(user.id, to_user.id, "ask_for_game", @ask_for_game.id, msg, "pending")

			json_render["msg"] = "Friendly duel sent to " + to_user.name + "."
			json_render["is_msg"] = 1
			render json: json_render, status: :ok and return
		end
	elsif (params[:game_type] == "war_random_match")
		puts "------ war_random_match -------"

		#----------------- Checking -----------------------
		if (!(wartime != nil && wartime.start_date.to_s < Time.zone.now.to_s && wartime.end_date.to_s > Time.zone.now.to_s))
			json_render["msg"] = "There is no war time currently.\nYou can ask for random fight only during war time."
			json_render["is_msg"] = 1
			render json: json_render, status: :ok and return
		end

		#AskForGame.where('status=? AND to_user_id is ?', "pending", nil)
		warp_a = WarParticipation.all.where('war_id=? AND guild_id=?',war_a.id, guild_a.id).first
		warp_b = WarParticipation.all.where('war_id=? AND guild_id!=?',war_a.id, guild_a.id).first
		guild_b = Guild.find(warp_b.guild_id)
		if (wartime.a == guild_b.id) 
			nb_unanswered_call = wartime.nb_unanswered_call_a
		else
			nb_unanswered_call = wartime.nb_unanswered_call_b
		end
		if (nb_unanswered_call >= war_a.max_unanswered_call)
			json_render["msg"] = "You can't anymore request a randome match, the opposing guild has reached its unanswered match limit."
			json_render["is_msg"] = 1
			render json: json_render, status: :ok and return
		end
		if (wartime.ongoing_match == true) #mettre true dans update et false dans update game (fin de match)
			json_render["msg"] = "A war time match is ongoing.\nYou can have only one war time match at the time."
			json_render["is_msg"] = 1
			render json: json_render, status: :ok and return
		end
		if (AskForGame.where('status=? AND to_user_id is ?', "pending", nil).size > 0)
			json_render["msg"] = "An invitation to random match is already in progress with this guild."
			json_render["is_msg"] = 1
			render json: json_render, status: :ok and return
		end
		#--------------------------------------------------

		@ask_for_game = AskForGame.new(
	 		from_user_id: user.id,
	 		to_user_id: nil,
	 		game_type: params[:game_type],
	 		status: "pending"
	 	)
	 	@ask_for_game.save

		# Send notif to all opponent guild
		for to_user in guild_b.users do
			puts "--- Notification sent to user: " + user.name
			msg = "War Random match by " + user.name + " from " + guild_a.name + ".\n You have 5 minutes to accept."
			send_notification(user.id, to_user.id, "ask_for_game", @ask_for_game.id, msg, "pending")
		end

		# Life time war declaration
		AskForWarTimerJob.set(wait: 5.minutes).perform_later(@ask_for_game.id, war_a.id, warp_a.id, warp_b.id)

		json_render["msg"] = "Random duel sent to all players of " + guild_b.name + ".\nFor a duration of 5 minutes."
		json_render["is_msg"] = 1
		render json: json_render, status: :ok and return

	elsif (params[:game_type] == "ladder_match_making")
		puts "------ ladder_match_making ---------"
		@game = Game.new(
			start_date: Time.zone.now,
			end_date: nil,
			context: nil,
			winner_id: nil,
			war_id: nil,
			war_time_id: nil,
			tournament_id: nil,
			channel_id: nil
		)
		@game.save

		@game_p1 = GameParticipation.new(
			user_id: user.id,
			game_id: @game.id,
			score: nil,
			is_winner: nil,
		)
		@game_p1.save
	
		@game_p2 = GameParticipation.new(
			user_id: to_user.id,
			game_id: @game.id,
			score: nil,
			is_winner: nil,
		)
		@game_p2.save

		@ask_for_game = AskForGame.new(
			from_user_id: user.id,
			to_user_id: to_user.id,
			game_type: "friendly_duel",
			status: "playing",
			game_id: @game.id
		)
		# FAIRE DES CHECK ICI !!!!!
		@ask_for_game.save
		json_render["ask_for_game"] = @ask_for_game
		render json: json_render, status: :ok and return
	else
		puts "------ error type --------=> " + params[:game_type].to_s

	end
  end

  # PATCH/PUT /ask_for_games/1
  # PATCH/PUT /ask_for_games/1.json
  def update
	puts "--------- PATCH/PUT /ask_for_games/1 --------"
	if (params[:status] == "ending")
		@ask_for_game.update(status: params[:status])
		return
	end

	#----------- Variable utils -------------------
	json_render = {}

	from_user = User.find(@ask_for_game.from_user_id)
	if (@ask_for_game.game_type == "war_random_match")
		@ask_for_game.update(
			to_user_id: params[:user_id],
		)
	end

	to_user = User.find(@ask_for_game.to_user_id)
	if (@ask_for_game.game_type == "war_random_match" || @ask_for_game.game_type == "war_duel")
		guild_a = from_user.guild_participations.first.guild
		the_war = guild_a.wars.where('wars.status=?', "ongoing").first
		wartime = WarTime.all.where('war_id=?', the_war.id).first
	end
	#---------------------------------------------

	# Global check
	#	Ne pas accepté si en tournois (si le tournois lance des match automatique)
	#	Test si le joueur est connecté hor war time
	if (AskForGame.where('status=? and (from_user_id=? or to_user_id=?)', "playing", from_user.id, from_user.id).size >= 1)
		json_render["msg"] = "Your opponent is currently in a duel.\nYou can try again after the end of the duel."
		json_render["is_msg"] = true
		json_render["delete_notif"] = false
		render json: json_render, status: :unprocessable_entity and return
	end
	if (AskForGame.where('status=? and (from_user_id=? or to_user_id=?)', "playing", to_user.id, to_user.id).size >= 1)
		json_render["msg"] = "You are in a duel.\nWait until the end to accept."
		json_render["is_msg"] = true
		json_render["delete_notif"] = false
		render json: json_render, status: :unprocessable_entity and return
	end

	@game = Game.new(
		start_date: Time.zone.now,
		end_date: nil,
		context: nil,
		status: "playing",
		winner_id: nil,
		war_id: nil,
		war_time_id: nil,
		tournament_id: nil,
		channel_id: nil
	)

	#GESTION DES DIFFERENT TYPE DE GAME
	if (@ask_for_game.game_type == "friendly_duel")
		#do some check
		@game.context = "friendly_duel"
	elsif (@ask_for_game.game_type == "war_random_match")
		#do some check
		if (@ask_for_game.status != "pending")
			json_render["msg"] = "Match request expired."
			json_render["is_msg"] = true
			json_render["delete_notif"] = true
			render json: json_render, status: :unprocessable_entity and return
		end

		@game.context = "war_random_match"
		@game.war_id = the_war.id
		@game.war_time_id = wartime.id
	elsif (@ask_for_game.game_type == "war_duel")
		#do some check

		@game.context = "war_duel"
		@game.war_id = the_war.id
	else
		puts "--------- wrong game type: " + @ask_for_game.game_type
	end

	# --------- Succes -----------
	@game.save

	@ask_for_game.update(
		status: "playing",
		game_id: @game.id
	)

	@game_p1 = GameParticipation.new(
		user_id: from_user.id,
		game_id: @game.id,
		score: nil,
		is_winner: nil,
	)
	@game_p1.save
	@game_p2 = GameParticipation.new(
		user_id: to_user.id,
		game_id: @game.id,
		score: nil,
		is_winner: nil,
	)
	@game_p2.save
	
	json_render["delete_notif"] = true
	json_render["ask_for_game"] = @ask_for_game
	render json: json_render, status: :ok and return
	#-----------------------------
  end

  # DELETE /ask_for_games/1
  # DELETE /ask_for_games/1.json
  def destroy
	puts "-------------  DELETE /ask_for_games/ ----------"
	if (@ask_for_game.game_type == "war_random_match")
		return
	end
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
end
