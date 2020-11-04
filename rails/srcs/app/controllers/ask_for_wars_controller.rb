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
  # POST /ask_for_wars.jsons
  def create
	puts "CREATE POST /ask_for_wars"
	puts params.to_json
	puts "--------------------------"
	
	#Global variable
	from_guild = User.find(params[:current_user_id]).guild_participations.first.guild
	from_guild_id = from_guild.id
	to_guild_id = params[:to_guild_id]

	#check if to_guild_id is in war

	#Création de la table war
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
	puts "--------------"

	#Création des tables war_time

	#Création de la table ask_for_wars
	@ask_for_war = AskForWar.new(
		from_guild_id: from_guild_id,
		to_guild_id: to_guild_id,
		includes_ladder: nil, # Ajouter champ dans le fornt
		war_id: @war.id,
		status: "pending"
	)
	@ask_for_war.save
	puts "----- ask_for_wars ----"
	puts @ask_for_war.to_json
	puts "-----------------------"

	#Création de la table notification
	msg_guild = "War decalration by " + from_guild.name
	msg_date =  "from " + params[:start_date] + " to " + params[:end_date]
	msg_unanswered = "Max unanswered match: " + params[:max_unanswered_call]
	msg_prize = "Prize pool: " + params[:prize_in_points]
	msg = msg_guild + "<br>" + msg_date + "<br>" + msg_unanswered + "<br>" + msg_prize

	from_user_id = Guild.find(from_guild_id).owner_id
	to_user_id = Guild.find(to_guild_id).owner_id
	@notification = Notification.new(
		from_user_id: from_user_id,
		user_id: to_user_id,
		table_type: "ask_for_war",
		table_id: @ask_for_war.id,
		message: msg,
		status: "pending"
	)
	puts "----- notification ----"
	puts @notification.to_json
	puts "-----------------------"

	#Envoi de la notifiction à l'owner de la guild
	@notification.save
    notif_channel = "notification_channel_" + to_user_id.to_s;
	ActionCable.server.broadcast(notif_channel, {notification: "On"})

    #respond_to do |format|
	#  if @ask_for_war.save
    #    format.json { render :show, status: :created, location: @ask_for_war }
    #  else
    #    format.json { render json: @ask_for_war.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # PATCH/PUT /ask_for_wars/1
  # PATCH/PUT /ask_for_wars/1.json
  def update
	puts "UPDATE /PUT /ask_for_wars/1"
	puts "----- ask_for_war ----"
	puts @ask_for_war.to_json
	puts "-----------------------"

	if (@ask_for_war.status == "pending")
		@ask_for_war.update(status: "accept")
		
		@wpp_from_guild = WarParticipation.new(
			guild_id: @ask_for_war.from_guild_id,
			war_id: @ask_for_war.war_id,
			war_points: 0,
			has_declared_war: true,
			nb_unanswered_call: 0,
			is_winner: nil,
			status: nil
		)
		from_guild = Guild.find(@ask_for_war.from_guild_id)
		from_guild.war_participation_id = @ask_for_war.war_id

		@wpp_to_guild = WarParticipation.new(
			guild_id: @ask_for_war.to_guild_id,
			war_id: @ask_for_war.war_id,
			war_points: 0,
			has_declared_war: false,
			nb_unanswered_call: 0,
			is_winner: nil,
			status: nil
		)
		to_guild = Guild.find(@ask_for_war.from_guild_id)
		to_guild.war_participation_id = @ask_for_war.war_id


    	#@wpp_from_guild.save

	end
	#puts "----- war_participation ----"
	#puts @wpp_from_guild.to_json
	#puts "-----------------------"

	respond_to do |format|
        format.json { render :show, status: :ok, location: @ask_for_war }
	end
	
    #respond_to do |format|
    #  if @ask_for_war.update(ask_for_war_params)
    #    format.html { redirect_to @ask_for_war, notice: 'Ask for war was successfully updated.' }
    #    format.json { render :show, status: :ok, location: @ask_for_war }
    #  else
    #    format.html { render :edit }
    #    format.json { render json: @ask_for_war.errors, status: :unprocessable_entity }
    #  end
    #end
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
