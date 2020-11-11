class WarParticipationsController < ApplicationController
  before_action :set_war_participation, only: [:show, :edit, :update, :destroy]

  def war_info
	puts "--------- war_info --------"
	#Variable utils
	json_render = {}
	user = User.find(params[:user_id].to_i)
	puts "--------- 1"
	if (user.guild_participation_id == nil || user.guild_participations.first.guild.war_participation_id == nil)
		json_render["is_war"] = false
		render json: json_render, status: :ok and return
	end
	puts "--------- 2"

	#Variable utils
	guild_a = user.guild_participations.first.guild
	puts "--------- 3"
	warp_a = WarParticipation.find(guild_a.war_participation_id)
	puts "--------- 4"
	the_war = guild_a.wars.where('wars.status=?', "ongoing").first
	puts "--------- 5", the_war.to_json, guild_a.to_json
	warp_b = WarParticipation.all.where('war_id=? AND guild_id!=?',the_war.id, guild_a.id).first
	puts "--------- 6"
	guild_b = Guild.find(warp_b.guild_id)
	puts "--------- 7"

	#is war finish => end of war
	puts "Time.zone.now > the_war.end_date", Time.zone.now, the_war.end_date
	if (Time.zone.now > the_war.end_date)
		puts "warp_a.war_points > warp_b.war_points", warp_a.war_points, warp_b.war_points
		if (warp_a.war_points > warp_b.war_points)
			warp_a.is_winner = true
			warp_b.is_winner = false
			the_war.winner_id = guild_a.id
			guild_a.points += the_war.prize_in_points
		elsif (warp_a.war_points < warp_b.war_points)
			warp_a.is_winner = false
			warp_b.is_winner = true
			the_war.winner_id = guild_b.id
			guild_b.points += the_war.prize_in_points
		else
			warp_a.is_winner = nil
			warp_b.is_winner = nil
			the_war.winner_id = nil
			guild_a.points += (the_war.prize_in_points / 2)
			guild_b.points += (the_war.prize_in_points / 2)
		end
		#guild_a
		guild_a.war_participation_id = nil
		guild_a.is_making_war = false
		warp_a.status = "finish"
		guild_a.save
		warp_a.save
		
		#guild_b
		guild_b.war_participation_id = nil
		guild_b.is_making_war = false
		warp_b.status = "finish"
		guild_b.save
		warp_b.save

		the_war.status = "finish"
		the_war.save
		
		#TO DO: envoyer une notif de fin de guerre
		json_render["is_war"] = false
		render json: json_render, status: :ok and return
	end

	#Ongoing war render war info
	json_render["is_war"] = true
	json_render["guild_name_a"] = guild_a.name
	json_render["guild_name_b"] = guild_b.name
	json_render["guild_score_a"] = warp_a.war_points
	json_render["guild_score_b"] = warp_b.war_points
	json_render["war_start"] = the_war.start_date
	json_render["war_end"] = the_war.end_date
	json_render["prize_pool"] = the_war.prize_in_points
	json_render["max_unanswered_call"] = the_war.max_unanswered_call
	json_render["opponents"] = guild_b.users
	render json: json_render, status: :ok and return
  end

  # GET /war_participations
  # GET /war_participations.json
  def index
  	@war_participations = WarParticipation.all
  end

  # GET /war_participations/1
  # GET /war_participations/1.json
  def show
  end

  # GET /war_participations/new
  def new
    @war_participation = WarParticipation.new
  end

  # GET /war_participations/1/edit
  def edit
  end

  # POST /war_participations
  # POST /war_participations.json
  def create
    @war_participation = WarParticipation.new(war_participation_params)

    respond_to do |format|
      if @war_participation.save
        format.html { redirect_to @war_participation, notice: 'War participation was successfully created.' }
        format.json { render :show, status: :created, location: @war_participation }
      else
        format.html { render :new }
        format.json { render json: @war_participation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /war_participations/1
  # PATCH/PUT /war_participations/1.json
  def update
    respond_to do |format|
      if @war_participation.update(war_participation_params)
        format.html { redirect_to @war_participation, notice: 'War participation was successfully updated.' }
        format.json { render :show, status: :ok, location: @war_participation }
      else
        format.html { render :edit }
        format.json { render json: @war_participation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /war_participations/1
  # DELETE /war_participations/1.json
  def destroy
    @war_participation.destroy
    respond_to do |format|
      format.html { redirect_to war_participations_url, notice: 'War participation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_war_participation
      @war_participation = WarParticipation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def war_participation_params
      params.require(:war_participation).permit(:guild_id, :war_id, :war_points, :has_declared_war, :nb_unanswered_call, :is_winner, :status)
	end
end