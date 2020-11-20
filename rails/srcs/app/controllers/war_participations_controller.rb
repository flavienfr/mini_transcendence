class WarParticipationsController < ApplicationController
  before_action :set_war_participation, only: [:show, :edit, :update, :destroy]

  def war_info
	puts "--------- war_info --------"
	#Variable utils
	json_render = {}
	user = User.find(params[:user_id].to_i)

	
	if (user.guild_participation_id == nil || user.guild_participations.first.guild.war_participation_id == nil)
		json_render["is_war"] = false
		render json: json_render, status: :ok and return
	end

	#Variable utils
	guild_a = user.guild_participations.first.guild
	warp_a = WarParticipation.find(guild_a.war_participation_id)
	the_war = guild_a.wars.where('wars.status=?', "ongoing").first
	warp_b = WarParticipation.all.where('war_id=? AND guild_id!=?',the_war.id, guild_a.id).first
	guild_b = Guild.find(warp_b.guild_id)

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
	json_render["war_times"] = WarTime.all.where('war_id=?', the_war.id)
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