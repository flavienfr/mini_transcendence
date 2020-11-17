class GuildsController < ApplicationController
  before_action :set_guild, only: [:show, :edit, :update, :destroy]

  # GET /guilds
  # GET /guilds.json
  def index
  @guilds = Guild.all.order(points: :desc)
  respond_to do |format|
    format.html
    format.json {render json: @guilds}
  end
  end

  # GET /guilds/1
  # GET /guilds/1.json
  def show
    if (params[:type] == "all_participations")
      users_with_id = {};
      User.all.each do |user|
        users_with_id[user.id] = user.name;
      end
      json_to_return = {};
      json_to_return["guild_participations"] = Guild.find_by(id: params[:guild_id]).guild_participations;
      json_to_return["users"] = users_with_id;
      json_to_return["user_participation"] = GuildParticipation.where("user_id = ? AND guild_id = ?", params[:user_id], params[:guild_id]).first;
      respond_to do |format|
        format.html
        format.json {render json: json_to_return}
      end
      return;
    end
	@guild = Guild.find(params[:id])
	render json: @guild
  end

  # GET /guilds/new
  def new
    @guild = Guild.new
  end

  # GET /guilds/1/edit
  def edit
  end

  # POST /guilds
  # POST /guilds.json
  def create
	json_render = {}
	if (Guild.where("name=?", params[:name]).size != 0)
		json_render["msg"] = "This guild name is already token"
		json_render["is_msg"] = 1
		respond_to do |format|
			format.html
			format.json {render json: json_render}
		end
		return
	end
	if (Guild.where("anagram=?", params[:anagram]).size != 0)
		json_render["msg"] = "This guild anagram is already token"
		json_render["is_msg"] = 1
		respond_to do |format|
			format.html
			format.json {render json: json_render}
		end
		return
	end

	@guild = Guild.new(
		name: params[:name],
		anagram: params[:anagram],
		points: 0,
		is_making_war: false,
		owner_id: params[:owner_id],
		war_participation_id: nil
	)
	@guild.save

	@guild_participation = GuildParticipation.new(
		user_id: params[:user_id],
		guild_id: @guild.id,
		is_admin: true,
		is_officer: false
	)
	@guild_participation.save 

	user = User.find(params[:user_id])
	user.guild_participation_id = @guild_participation.id;
	user.save

	respond_to do |format|
		  format.html { redirect_to @guild, notice: 'Guild was successfully updated.' }
		  format.json { render :show, status: :ok, location: @guild }
	end
  end

  # PATCH/PUT /guilds/1
  # PATCH/PUT /guilds/1.json
  def update
    respond_to do |format|
      if @guild.update(guild_params)
        format.html { redirect_to @guild, notice: 'Guild was successfully updated.' }
        format.json { render :show, status: :ok, location: @guild }
      else
        format.html { render :edit }
        format.json { render json: @guild.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /guilds/1
  # DELETE /guilds/1.json
  def destroy
    @guild.destroy
    respond_to do |format|
      format.html { redirect_to guilds_url, notice: 'Guild was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_guild
      @guild = Guild.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def guild_params
      params.require(:guild).permit(:name, :anagram, :points, :is_making_war, :owner_id)
    end
end
