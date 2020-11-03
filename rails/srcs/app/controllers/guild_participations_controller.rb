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

	#if in war can't quit
	if (guild.is_making_war) #war_participation_id ?
		return #erros message can't quit during war
	end

	user.guild_participation_id = nil
	user.save

	if (guild_size === 1)
		@guild_participation.destroy
		guild.destroy
		return
	end

	if (@guild_participation.is_admin)
		new_owner = guild.users.order(points: :desc).first
		guild.owner_id = new_owner.id
		new_owner.guild_participation_id.is_owner = true
	end

	@guild_participation.destroy
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
