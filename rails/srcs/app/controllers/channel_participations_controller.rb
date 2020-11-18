class ChannelParticipationsController < ApplicationController
  before_action :set_channel_participation, only: [:show, :edit, :update, :destroy]

  # GET /channel_participations
  # GET /channel_participations.json
  def index
    puts params;
    if (params[:type] == "direct")
      channel = Channel.find_by(name: params[:name]);
      respond_to do |format|
        format.html
        format.json {render json: channel.users}
      end
    elsif (params[:type] == "facing_user")
      channel_participations = Channel.find_by(id: params[:receiver_id]).channel_participations;
      channel_participation = channel_participations.where.not("user_id = ?", params[:user_id]).first;
      respond_to do |format|
        format.html
        format.json {render json: channel_participation}
      end
    elsif (params[:type] == "all")
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
      channel_participations = ChannelParticipation.where("user_id = ? AND channel_id = ?", params[:user_id], params[:receiver_id]).first;
      respond_to do |format|
        format.html
        format.json {render json: channel_participations}
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
      if (Channel.where("name = ? AND scope = 'direct'", channel_name).size == 0)
        @new_channel = {};
        @new_channel["name"] = channel_name;
        @new_channel["scope"] = params[:scope];
        @channel_to_save = Channel.new(@new_channel);
        if !(@channel_to_save.save)
          respond_to do |format|
            format.html
            format.json {render json: @channel_to_save.errors, status: :unprocessable_entity}
          end
          return;
        end
      end
      channel = Channel.where("name = ? AND scope = ?", channel_name, params[:scope]).last;
      if (ChannelParticipation.where("user_id = ? AND channel_id = ?", params[:user_id], channel.id).size == 0)
        params[:channel_participation]["user_id"] = params[:user_id];
        params[:channel_participation]["channel_id"] = channel.id;
        @channel_participation = ChannelParticipation.new(channel_participation_params);
        @channel_participation.save;
        params[:channel_participation]["user_id"] = params[:receiver_id];
        params[:channel_participation]["channel_id"] = channel.id;
        @channel_participation = ChannelParticipation.new(channel_participation_params);
        @channel_participation.save;
      end
      respond_to do |format|
        format.html
        format.json {render json: channel}
      end
    elsif (params[:scope] == "public-group" || params[:added])
      if (ChannelParticipation.where("user_id = ? AND channel_id = ?", params[:user_id], params[:receiver_id]).size == 0)
        params[:channel_participation]["user_id"] = params[:user_id];
        params[:channel_participation]["channel_id"] = params[:receiver_id];
        if (Channel.find_by(id: params[:receiver_id]).channel_participations.size == 0)#si il y avait aucun participants alors le seul nouveau devient owner and admin
          params[:channel_participation]["is_owner"] = true;
          params[:channel_participation]["is_admin"] = true;
        end
        @channel_participation = ChannelParticipation.new(channel_participation_params);
        @channel_participation.save;
        if (Channel.find_by(id: params[:receiver_id]).channel_participations.size == 1)
          Channel.find_by(id: params[:receiver_id]).update(owner_id: @channel_participation.user_id);
        end
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
        if (ChannelParticipation.where("user_id = ? AND channel_id = ?", params[:user_id], params[:receiver_id]).size == 0)
          params[:channel_participation]["user_id"] = params[:user_id];
          params[:channel_participation]["channel_id"] = params[:receiver_id];
          if (Channel.find_by(id: params[:receiver_id]).channel_participations.size == 0)
            params[:channel_participation]["is_owner"] = true;
            params[:channel_participation]["is_admin"] = true;
          end
          @channel_participation = ChannelParticipation.new(channel_participation_params);
          @channel_participation.save;
          if (Channel.find_by(id: params[:receiver_id]).channel_participations.size == 1)
            Channel.find_by(id: params[:receiver_id]).update(owner_id: @channel_participation.user_id);
          end
          ft_add_notif("you got added to group: " + Channel.find_by(id: params[:receiver_id]).name, params[:user_id]);
        end
        respond_to do |format|
          format.html
          format.json { render json: {res: true}};
        end
      else
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
    if (params[:type] == "new_owner")
      params["channel_participation"][:is_owner] = true;
      params["channel_participation"][:is_admin] = true;
      channel = Channel.find_by(id: params[:channel_id]);
      old_owner_id = channel.owner_id;
      old_owner_channel_participation = channel.channel_participations.find_by(user_id: old_owner_id);
      if (old_owner_channel_participation)
        old_owner_channel_participation.update(is_owner: nil, is_admin: nil);
      end
      channel.update(owner_id: params[:user_id]);
    end
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
    puts params;
    channelP_info = ChannelParticipation.find_by(id: params[:id]);
    was_owner = false;
    channel = channelP_info.channel;
    if (channelP_info.is_owner)
      was_owner = true;
    end
    @channel_participation.destroy
    if (was_owner)
      next_channelP = channel.channel_participations.first;
      if (next_channelP)
        next_channelP.update(is_owner: true, is_admin: true);
        Channel.find_by(id: next_channelP.channel_id).update(owner_id: next_channelP.user_id);
        ft_add_notif("you are now owner of group: " + channel.name, next_channelP.user_id);
      # else no second => no participants ?
      end
    end
    # @channel_participation.destroy
    ActionCable.server.broadcast("notification_channel_" + channelP_info[:user_id].to_s, {kicked_from: channel});
    channel.channel_participations.each do |participation|
      ActionCable.server.broadcast("notification_channel_" + participation.user_id.to_s, {refresh: channel});
    end
    admin_users = User.where("is_admin = ? ", true);
    if (channel.channel_participations.size > 0)
      admin_users = admin_users.where.not("id IN (?)", channel.channel_participations.pluck(:user_id));
    end
    admin_users.each do |participation|
      #if (channelP_info.user_id != participation.id)
        ActionCable.server.broadcast("notification_channel_" + participation.id.to_s, {refresh: channel});
      #end
    end
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
