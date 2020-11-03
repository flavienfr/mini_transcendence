class GuildsController < ApplicationController
  before_action :set_guild, only: [:show, :edit, :update, :destroy]

  # GET /guilds
  # GET /guilds.json
  def index
	@guilds = Guild.all
  end

  # GET /guilds/1
  # GET /guilds/1.json
  def show
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
	@guild = Guild.new(guild_params)
	@guild.save
	#tout remplir
	@guild_participation = GuildParticipation.new(
		user_id: params[:user_id],
		guild_id: @guild.id,
		is_admin: true,
		is_officer: false
		#add is in war
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
