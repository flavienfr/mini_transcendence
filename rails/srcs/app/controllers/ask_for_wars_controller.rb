class AskForWarsController < ApplicationController
  before_action :set_ask_for_war, only: [:show, :edit, :update, :destroy]

  # GET /ask_for_wars
  # GET /ask_for_wars.json
  def index
    @ask_for_wars = AskForWar.all
  end

  # GET /ask_for_wars/1
  # GET /ask_for_wars/1.json
  def show
  end

  # GET /ask_for_wars/new
  def new
    @ask_for_war = AskForWar.new
  end

  # GET /ask_for_wars/1/edit
  def edit
  end

  # POST /ask_for_wars
  # POST /ask_for_wars.json
  def create
	puts "----- ask_for_wars ----"
	puts ask_for_war_params
	puts "---------"

	@war = War.new(
		start_date: params[:start_date],
		end_date: params[:end_date],
		prize_in_points: params[:prize_in_points],
		max_unanswered_call: params[:max_unanswered_call],
		status: "pending"
	)
	@war.save
	puts "----- War ----"
	puts @war.to_json
	puts "---------"

	from_guild_id = User.find(params[:current_user_id]).guild_participations.first.guild.id
	@ask_for_war = AskForWar.new(
		from_guild_id: from_guild_id,
		to_guild_id: params[:to_guild_id],
		includes_ladder: nil, # Ajouter champ dans le fornt
		war_id: @war.id,
		status: "pending"
	)
	puts "----- ask_for_wars ----"
	puts @ask_for_war.to_json
	puts "---------"
	
	

    #@ask_for_war = AskForWar.new(ask_for_war_params)
#
    #respond_to do |format|
    #  if @ask_for_war.save
    #    format.html { redirect_to @ask_for_war, notice: 'Ask for war was successfully created.' }
    #    format.json { render :show, status: :created, location: @ask_for_war }
    #  else
    #    format.html { render :new }
    #    format.json { render json: @ask_for_war.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # PATCH/PUT /ask_for_wars/1
  # PATCH/PUT /ask_for_wars/1.json
  def update
    respond_to do |format|
      if @ask_for_war.update(ask_for_war_params)
        format.html { redirect_to @ask_for_war, notice: 'Ask for war was successfully updated.' }
        format.json { render :show, status: :ok, location: @ask_for_war }
      else
        format.html { render :edit }
        format.json { render json: @ask_for_war.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ask_for_wars/1
  # DELETE /ask_for_wars/1.json
  def destroy
    @ask_for_war.destroy
    respond_to do |format|
      format.html { redirect_to ask_for_wars_url, notice: 'Ask for war was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ask_for_war
      @ask_for_war = AskForWar.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ask_for_war_params
      params.require(:ask_for_war).permit(:from_guild_id, :to_guild_id, :terms, :includes_ladder, :war_id, :status)
    end
end
