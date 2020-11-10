class WarParticipationsController < ApplicationController
  before_action :set_war_participation, only: [:show, :edit, :update, :destroy]

  def war_info
	puts "--------- war_info --------"
	json_render = {}
	user = User.find(params[:user_id].to_i)

	puts "user.guild_participations ", user.guild_participations
	if (user.guild_participation_id == nil)
		puts "nil gp"
		json_render["is_war"] = false
		render json: json_render, status: :ok and return
	end
	puts "gp != nil"

	json_render["is_war"] = true
	json_render["user_test"] = params[:user_id].to_i
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
