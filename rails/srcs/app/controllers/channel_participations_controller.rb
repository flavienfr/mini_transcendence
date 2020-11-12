class ChannelParticipationsController < ApplicationController
  before_action :set_channel_participation, only: [:show, :edit, :update, :destroy]

  # GET /channel_participations
  # GET /channel_participations.json
  def index
    puts params;
    if (params[:type] == "direct")
      @channel = Channel.find_by(name: params[:name]);
      puts @channel.to_json;
      respond_to do |format|
        format.html
        format.json {render json: @channel.users}
      end
    elsif (params[:type] == "facing_user")
      puts "FACE";
      channel_participations = Channel.find_by(id: params[:receiver_id]).channel_participations;
      channelP = channel_participations.where.not("user_id = ?", params[:user_id]).first;
      puts channelP.to_json;
      respond_to do |format|
        format.html
        format.json {render json: channelP}
      end
    elsif (params[:type] == "all")
      puts "ALL !";
      channel_participations = Channel.find_by(id: params[:receiver_id]).channel_participations;
      in_user_id_order = {};
      channel_participations.each do |participant|
        in_user_id_order[participant.user_id] = participant;
      end
      respond_to do |format|
        format.html
        format.json {render json: in_user_id_order}
      end
    else
      @channel_participations = ChannelParticipation.where("user_id = ? AND channel_id = ?", params[:user_id], params[:receiver_id]).first;
      respond_to do |format|
        format.html
        format.json {render json: @channel_participations}
      end
    end
  end

  # GET /channel_participations/1
  # GET /channel_participations/1.json
  def show
  end

  # GET /channel_participations/new
  def new
    @channel_participation = ChannelParticipation.new
  end

  # GET /channel_participations/1/edit
  def edit
  end

  # POST /channel_participations
  # POST /channel_participations.json
  def create
    puts params;
    if (params[:scope] == "direct")
      smaller = params[:user_id] < params[:receiver_id] ? params[:user_id] : params[:receiver_id];
      bigger = params[:user_id] < params[:receiver_id] ? params[:receiver_id] : params[:user_id];
      channel_name = "conversation_channel_" + smaller.to_s + "_" + bigger.to_s;
      if (Channel.where("name = ? AND scope = 'direct'", channel_name).size > 0)
        puts "exist !";
      else
        puts "create channel !" + channel_name;
        @new_channel = {};
        @new_channel["name"] = channel_name;
        @new_channel["scope"] = params[:scope];
        @channel_to_save = Channel.new(@new_channel);
        @channel_to_save.save;
        puts "hey--------";
      end
      channel = Channel.where("name = ? AND scope = ?", channel_name, params[:scope]).last;
      if (ChannelParticipation.where("user_id = ? AND channel_id = ?", params[:user_id], channel.id).size > 0)
        puts "channelP exist !"
      else
        puts "channelP doesnt exist"
        # channel_id = Channel.find_by(name: channel_name).id;
        @new_channelP = {};
        @new_channelP["user_id"] = params[:user_id];
        @new_channelP["channel_id"] = channel.id;
        puts @new_channelP;
        @new_channelP_to_save = ChannelParticipation.new(@new_channelP);
        @new_channelP_to_save.save;
        @new_channelP["user_id"] = params[:receiver_id];
        @new_channelP["channel_id"] = channel.id;
        @new_channelP_to_save = ChannelParticipation.new(@new_channelP);
        @new_channelP_to_save.save;
      end
      respond_to do |format|
        format.html
        format.json {render json: channel}
      end
    elsif (params[:scope] == "public-group" || params[:added])
      if (ChannelParticipation.where("user_id = ? AND channel_id = ?", params[:user_id], params[:receiver_id]).size == 0)
        channelP = {};
        channelP["user_id"] = params[:user_id];
        channelP["channel_id"] = params[:receiver_id];
        if (Channel.find_by(id: params[:receiver_id]).channel_participations.size == 0)#si il y avait aucun participants alors le seul nouveau devient owner and admin
          channelP["is_owner"] = true;
          channelP["is_admin"] = true;
        end
        puts "a";
        puts channelP;
        puts "b";
        channelP_to_save = ChannelParticipation.new(channelP);
        channelP_to_save.save;
        ft_add_notif("you got added to group: " + Channel.find_by(id: params[:receiver_id]).name, params[:user_id]);
      end
      respond_to do |format|
        format.html
        format.json {render json: ChannelParticipation.where("user_id = ? AND channel_id = ?", params[:user_id], params[:receiver_id]).first.channel}
      end
    elsif (params[:scope] == "private-group")
      respond_to do |format|
        format.html
        format.json {render json: ChannelParticipation.where("user_id = ? AND channel_id = ?", params[:user_id], params[:receiver_id]).first.channel}
      end
    else
      if (params[:scope] == "protected-group" && BCrypt::Password.new(Channel.find_by(id: params[:receiver_id]).password) == params[:password])
        puts "ok password correct !"
        channelP = {};
        channelP["user_id"] = params[:user_id];
        channelP["channel_id"] = params[:receiver_id];
        if (Channel.find_by(id: params[:receiver_id]).channel_participations.size == 0)
          channelP["is_owner"] = true;
          channelP["is_admin"] = true;
        end
        channelP_to_save = ChannelParticipation.new(channelP);
        channelP_to_save.save;
        ft_add_notif("you got added to group: " + Channel.find_by(id: params[:receiver_id]).name, params[:user_id]);
        respond_to do |format|
          format.html
          format.json { render json: {res: true}};
        end
      else
        puts "protected"
        respond_to do |format|
          format.html
          format.json { render json: {res: false}};
        end
      end
    end
    # @channel_participation = ChannelParticipation.new(channel_participation_params)

    # respond_to do |format|
    #   if @channel_participation.save
    #     format.html { redirect_to @channel_participation, notice: 'Channel participation was successfully created.' }
    #     format.json { render :show, status: :created, location: @channel_participation }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @channel_participation.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /channel_participations/1
  # PATCH/PUT /channel_participations/1.json
  def update
    puts params;
    if (params[:is_admin] == "not")
      params["channel_participation"][:is_admin] = nil;
    end
    if (params[:status] == "none")
      params["channel_participation"][:status] = nil;
      params["channel_participation"][:unmute_datetime] = nil;
    end
    if (params[:status] == "banned")
      params["channel_participation"][:unmute_datetime] = nil;
      channel = ChannelParticipation.find_by(id: params[:id]).channel;
      ActionCable.server.broadcast("notification_channel_" + params[:user_id].to_s, {kicked_from: channel});
    end
    if (params[:minutes])
      params["channel_participation"][:status] = "muted";
      params["channel_participation"][:unmute_datetime] = (Time.now.to_datetime + params[:minutes].minutes).to_datetime;
    end
    puts params;
    respond_to do |format|
      if @channel_participation.update(channel_participation_params)
        format.html { redirect_to @channel_participation, notice: 'Channel participation was successfully updated.' }
        format.json { render :show, status: :ok, location: @channel_participation }
      else
        format.html { render :edit }
        format.json { render json: @channel_participation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /channel_participations/1
  # DELETE /channel_participations/1.json
  def destroy
    channelP_info = ChannelParticipation.find_by(id: params[:id]);
    channel = channelP_info.channel;
    if (channelP_info.is_owner)
      next_channelP = channel.channel_participations.second;
      if (next_channelP)
        next_channelP.update(is_owner: true, is_admin: true);
        ft_add_notif("you are now owner of group: " + channel.name, next_channelP.user_id);
      # else no second => no participants ?
      end
    end
    @channel_participation.destroy
    ActionCable.server.broadcast("notification_channel_" + channelP_info[:user_id].to_s, {kicked_from: channel});
    respond_to do |format|
      format.html { redirect_to channel_participations_url, notice: 'Channel participation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_channel_participation
      @channel_participation = ChannelParticipation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def channel_participation_params
      params.require(:channel_participation).permit(:id, :user_id, :channel_id, :is_owner, :is_admin, :status, :unmute_datetime)
    end

    def ft_add_notif(msg, id)
      notification = {};
      notification["from_user_id"] = id;
      notification["user_id"] = id;
      notification["table_type"] = "information";
      notification["message"] = msg;
      notification_to_save = Notification.new(notification);
      notification_to_save.save();
      ActionCable.server.broadcast("notification_channel_" + id.to_s, {notification: "on"});
    end
end
