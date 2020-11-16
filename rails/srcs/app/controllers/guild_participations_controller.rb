class GuildParticipationsController < ApplicationController
  before_action :set_guild_participation, only: [:show, :edit, :update, :destroy]

  # GET /guild_participations
  # GET /guild_participations.json
  def index
    @guild_participations = GuildParticipation.all
  end

  # GET /guild_participations/1
  # GET /guild_participations/1.json
  def show
	@guildparticip = GuildParticipation.find(params[:id])
	render json: @guildparticip
  end

  # GET /guild_participations/new
  def new
    @guild_participation = GuildParticipation.new
  end

  # GET /guild_participations/1/edit
  def edit
  end

  # POST /guild_participations
  # POST /guild_participations.json
  def create
	#To Do : send notification to the owner of the guild before joining the guild

    @guild_participation = GuildParticipation.new(
		user_id: params[:user_id],
		guild_id: params[:guild_id],
		is_admin: false,
		is_officer: false 
	)
	@guild_participation.save

	user = User.find(params[:user_id])
	user.guild_participation_id = @guild_participation.id
	user.save

	puts "@guild_participation", @guild_participation.to_json
  end

  # PATCH/PUT /guild_participations/1
  # PATCH/PUT /guild_participations/1.json
  def update
    if (params[:type] == "new_owner")
      params["guild_participation"][:is_admin] = true;
      params["guild_participation"][:is_officer] = false;
      guild = Guild.find_by(id: params[:guild_id]);
      old_admin_id = guild.owner_id;
      old_admin_guild_participation = guild.guild_participations.find_by(user_id: old_admin_id);
      if (old_admin_guild_participation)
        old_admin_guild_participation.update(is_admin: nil, is_officer: nil);
      end
      guild.update(owner_id: params[:user_id]);
    end
    respond_to do |format|
      if @guild_participation.update(guild_participation_params)
        format.html { redirect_to @guild_participation, notice: 'Guild participation was successfully updated.' }
        format.json { render :show, status: :ok, location: @guild_participation }
      else
        format.html { render :edit }
        format.json { render json: @guild_participation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /guild_participations/1
  # DELETE /guild_participations/1.json
  def destroy
	puts "-------- guild_participations --------"
	guild = @guild_participation.guild
	user = @guild_participation.user
	guild_size = guild.users.size 
	is_admin = @guild_participation.is_admin

	#if in war can't quit
	if (guild.is_making_war) #war_participation_id ?
		return #erros message can't quit during war
	end

	user.guild_participation_id = nil
	user.save
	@guild_participation.destroy

	if (guild_size == 1)
		guild.destroy
		return
	end

	if (is_admin)
		puts "--------------is adm"
		new_owner = guild.users.order(points: :desc).first
		guild.owner_id = new_owner.id
		new_guild_p = new_owner.guild_participations.first
		new_guild_p.is_admin = true
		guild.owner_id = new_owner.id
		new_owner.save
		new_guild_p.save
		guild.save
	end
	
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_guild_participation
      @guild_participation = GuildParticipation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def guild_participation_params
      params.require(:guild_participation).permit(:user_id, :guild_id, :is_admin, :is_officer)
    end
end
