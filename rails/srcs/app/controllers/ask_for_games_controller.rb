class AskForGamesController < ApplicationController
  before_action :set_ask_for_game, only: [:show, :edit, :update, :destroy]

  # GET /ask_for_games
  # GET /ask_for_games.json
  def index
    if (params[:to_user_id])
      @game = AskForGame.where("to_user_id = ? AND status='playing'", params[:to_user_id]).last
    else
      @game = AskForGame.where("from_user_id = ? AND status='playing'", params[:from_user_id]).last
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
	puts params
	
	#Variable utils
	json_render = {}
	user = User.find(params[:user_id].to_i)
	guild_a = user.guild_participations.first.guild
	warp_a = WarParticipation.find(guild_a.war_participation_id)
	the_war = guild_a.wars.where('wars.status=?', "ongoing").first
	warp_b = WarParticipation.all.where('war_id=? AND guild_id!=?',the_war.id, guild_a.id).first
	guild_b = Guild.find(warp_b.guild_id)
	wartime = WarTime.all.where('war_id=?', the_war.id)

	if (params[:type] == "war_random_match")
		puts "------ war_random_match ---------"
		if (wartime.empty? == false && wartime.start_date.to_s < Time.zone.now.to_s && wartime.end_date.to_s > Time.zone.now.to_s)
			if (wartime.ongoing_match)
				json_render["msg"] = "A war time match is ongoing.\nYou can have only one war time match at the time."
				json_render["is_msg"] = 1
				render json: json_render, status: :ok and return
			end
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
    respond_to do |format|
      if @ask_for_game.update(ask_for_game_params)
        format.html { redirect_to @ask_for_game, notice: 'Ask for game was successfully updated.' }
        format.json { render :show, status: :ok, location: @ask_for_game }
      else
        format.html { render :edit }
        format.json { render json: @ask_for_game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ask_for_games/1
  # DELETE /ask_for_games/1.json
  def destroy
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
