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
    @guild = Guild.find(GuildParticipation.find(params[:id]).guild_id)
    render json: @guild
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
    @guild_participation = GuildParticipation.new(guild_participation_params)

    respond_to do |format|
      if @guild_participation.save
        format.html { redirect_to @guild_participation, notice: 'Guild participation was successfully created.' }
        format.json { render :show, status: :created, location: @guild_participation }
      else
        format.html { render :new }
        format.json { render json: @guild_participation.errors, status: :unprocessable_entity }
      end
    end
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
    @guild_participation.destroy
    respond_to do |format|
      format.html { redirect_to guild_participations_url, notice: 'Guild participation was successfully destroyed.' }
      format.json { head :no_content }
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
