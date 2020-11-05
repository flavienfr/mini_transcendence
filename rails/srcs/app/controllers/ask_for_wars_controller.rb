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
	
	#UTILS VARIABLE
	from_guild = User.find(params[:current_user_id]).guild_participations.first.guild
	from_guild_id = from_guild.id
	to_guild = Guild.find(params[:to_guild_id])
	to_guild_id = params[:to_guild_id]
	json_render = {}

	#CHECK PARAMS TO DO: *if to_guild_id is in war
	if (to_guild.is_making_war == true)
		json_render["msg"] = to_guild.name + " is aleready in war"
		json_render["is_msg"] = 1
		respond_to do |format|
			format.html
			format.json {render json: json_render}
    	end
		return
	end
	if (AskForWar.where('from_guild_id=?', 3).size > 0)
		json_render["msg"] = "War declaration already in progress"
		json_render["is_msg"] = 1
		respond_to do |format|
			format.html
			format.json {render json: json_render}
    	end
		return
	end
	if (params[:prize_in_points].to_i > from_guild.points)
		json_render["msg"] = "You can't engage more points than you've got.\n" + from_guild.name + " has " + from_guild.points.to_s + " points."
		json_render["is_msg"] = 1
		respond_to do |format|
			format.html
			format.json {render json: json_render}
    	end
		return
	end
	if (params[:prize_in_points].to_i > to_guild.points)
		json_render["msg"] = "You can't engage more points than your opponent got.\n" + to_guild.name + " has " + to_guild.points.to_s + " points."
		json_render["is_msg"] = 1
		respond_to do |format|
			format.html
			format.json {render json: json_render}
    	end
		return
	end

	#WAR TABLE CREATION
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

	#WAR_TIME TABLE(S) CREATION

	#ASK_FOR_WAR TABLE CREATION
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

	#NOTIFICATION TABLE CREATION
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

	#SENDING NOTIFICATION TO_GUILD
	@notification.save
    notif_channel = "notification_channel_" + to_user_id.to_s;
	ActionCable.server.broadcast(notif_channel, {notification: "On"})

	json_render["msg"] = "War declaration send to " + to_guild.name
	json_render["is_msg"] = 1
	respond_to do |format|
		format.html
		format.json {render json: json_render}
	end
  end

  # PATCH/PUT /ask_for_wars/1
  # PATCH/PUT /ask_for_wars/1.json
  def update
	puts "UPDATE /PUT /ask_for_wars/1"
	puts "----- ask_for_war ----"
	puts @ask_for_war.to_json
	puts "-----------------------"

	#check if not in war both guilds
	#check points both guilds

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
		@wpp_from_guild.save
		from_guild = Guild.find(@ask_for_war.from_guild_id)
		from_guild.war_participation_id = @wpp_from_guild.id
		from_guild.is_making_war = true
		from_guild.save
		puts "----- wpp_from_guild ----"
		puts @wpp_from_guild.to_json
		puts "-----------------------"

		@wpp_to_guild = WarParticipation.new(
			guild_id: @ask_for_war.to_guild_id,
			war_id: @ask_for_war.war_id,
			war_points: 0,
			has_declared_war: false,
			nb_unanswered_call: 0,
			is_winner: nil,
			status: nil
		)
		@wpp_to_guild.save
		to_guild = Guild.find(@ask_for_war.from_guild_id)
		to_guild.war_participation_id = @wpp_to_guild.id
		to_guild.is_making_war = true
		to_guild.save
		puts "----- wpp_to_guild ----"
		puts @wpp_to_guild.to_json
		puts "-----------------------"
	end

	respond_to do |format|
        format.json { render :show, status: :ok, location: @ask_for_war }
	end
  end

  # DELETE /ask_for_wars/1
  # DELETE /ask_for_wars/1.json
  def destroy
	puts "----- destroy ask_for_wars ----"
	war = War.find(AskForWar.find(@ask_for_war.id).war_id)
	@ask_for_war.destroy
	war.destroy

	# Todo bonus: Renvoyer une notif(depuis controler destroy) pour annoncer le refus

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
