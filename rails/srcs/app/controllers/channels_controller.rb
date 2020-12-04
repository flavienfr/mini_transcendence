class ChannelsController < ApplicationController
  before_action :set_channel, only: [:show, :edit, :update, :destroy]

  # GET /channels
  # GET /channels.json
  def index
    # @channels = Channel.all
    if (params[:type] == "all")
      respond_to do |format|
        format.html
        format.json {render json: Channel.where.not("scope = ?", "direct")}
      end
    else
      joignable_groups = Channel.where("scope = ? OR scope = ?", "public-group", "protected-group");
      channel_participations = User.find_by(id: current_user.id).channel_participations;
      private_groups_not_in = Channel.where("scope = ?", "private-group");
      if (channel_participations.size > 0)
        private_groups_not_in = private_groups_not_in.where.not("id IN (?)", channel_participations.pluck(:channel_id));
      end
      if (channel_participations.size > 0)
        joignable_groups = joignable_groups.where.not("id IN (?)", channel_participations.pluck(:channel_id));
      end
      direct_channels = Channel.where("scope = ?", "direct");#pour enlever les messages directs
      if (direct_channels.size > 0)
        channel_participations = channel_participations.where.not("channel_id IN (?)", direct_channels.pluck(:id));
      end
      channel_participations_banned = channel_participations.where("status = 'banned'");
      if (channel_participations_banned.size > 0)
        channel_participations = channel_participations.where.not("id IN (?)", channel_participations_banned.pluck(:id));
      end
      in_channels = Channel.where("id IN (?)", channel_participations.pluck(:channel_id));
      json_to_return = {};
      json_to_return["users"] = User.all;
      json_to_return["channels_joignable"] = joignable_groups;
      json_to_return["channels_in"] = in_channels;
      json_to_return["channels_private_not_in"] = private_groups_not_in;
      respond_to do |format|
        format.html
        format.json {render json: json_to_return}
      end
    end
  end

  # GET /channels/1
  # GET /channels/1.json
  def show
    respond_to do |format|
      format.html
      format.json {render json: Channel.find_by(id: params[:id])}
    end
  end

  # GET /channels/new
  def new
    @channel = Channel.new
  end

  # GET /channels/1/edit
  def edit
  end

  # POST /channels
  # POST /channels.json
  def create
    if (params[:password] && params[:password].length > 25)
      respond_to do |format|
        format.html
        format.json {render json: {error_text: "password too large"}, status: :unprocessable_entity}
      end
      return;
    end
    if (params[:password] && params[:password].length > 0)
      params["channel"]["password"] = BCrypt::Password.create(params[:password]);
    end
    @channel = Channel.new(channel_params);
    respond_to do |format|
      if @channel.save;
        @new_channelP = {};
        @new_channelP["user_id"] = params[:owner_id];
        @new_channelP["channel_id"] = @channel.id;
        @new_channelP["is_owner"] = true;
        @new_channelP["is_admin"] = true;
        @new_channelP_to_save = ChannelParticipation.new(@new_channelP);
        @new_channelP_to_save.save;
        format.html { redirect_to @channel, notice: 'Channel was successfully created.' }
        format.json { render :show, status: :created, location: @channel }
      else
        format.html { render :new }
        format.json { render json: @channel.errors, status: :unprocessable_entity }
      end
    end
    #rajouter admin status owner

    # @channel = Channel.new(channel_params)

    # respond_to do |format|
    #   if @channel.save
    #     format.html { redirect_to @channel, notice: 'Channel was successfully created.' }
    #     format.json { render :show, status: :created, location: @channel }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @channel.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /channels/1
  # PATCH/PUT /channels/1.json
  def update
    if (user_is_channel_owner?(params[:id]))
      if (params["channel"]["scope"] == "protected-group" && params["channel"][:password] && params["channel"][:password].length > 25)
        respond_to do |format|
          format.html
          format.json {render json: {error_text: "password too large"}, status: :unprocessable_entity}
        end
        return;
      end
      if (params["channel"][:password] && params["channel"][:password].length > 0)
        params["channel"][:password] = BCrypt::Password.create(params["channel"][:password]);
      end
      if (params["channel"][:scope] != "protected-group")
        params["channel"][:password] = nil;
      end
      respond_to do |format|
        if @channel.update(channel_params)
          format.html { redirect_to @channel, notice: 'Channel was successfully updated.' }
          format.json { render :show, status: :ok, location: @channel }
        else
          format.html { render :edit }
          format.json { render json: @channel.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html
        format.json {render json: {error_text: "not_authorized"}, status: :unauthorized}
      end
    end
  end

  # DELETE /channels/1
  # DELETE /channels/1.json
  def destroy
    if (user_is_admin_owner?)
      channel = Channel.find_by(id: params[:id]);
      channel_participations = channel.channel_participations;
      channel_participations.each do |participant|
        ActionCable.server.broadcast("notification_channel_" + participant.user_id.to_s, {kicked_from: channel});
      end
      Channel.find_by(id: params[:id]).messages.destroy_all;
      Channel.find_by(id: params[:id]).channel_participations.destroy_all;
      @channel.destroy;
      User.all.where("is_admin = ?", true).each do |admin|
        ActionCable.server.broadcast("notification_channel_" + admin.id.to_s, {channel_destroyed: params[:id]});
      end
      respond_to do |format|
        format.html { redirect_to channels_url, notice: 'Channel was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html
        format.json {render json: {error_text: "not_authorized"}, status: :unauthorized}
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_channel
      @channel = Channel.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def channel_params
      params.require(:channel).permit(:name, :scope, :password, :owner_id)
    end
end
