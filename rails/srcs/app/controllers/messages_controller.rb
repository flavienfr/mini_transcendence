class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  # GET /messages
  # GET /messages.json
  def index
    puts params;
    if params[:scope] == "direct"
      smaller = params[:user_id].to_i < params[:receiver_id].to_i ? params[:user_id] : params[:receiver_id];
      bigger = params[:user_id].to_i < params[:receiver_id].to_i ? params[:receiver_id] : params[:user_id];
      channel_name = "conversation_channel_" + smaller.to_s + "_" + bigger.to_s;
      @channel = Channel.where("name = ? AND scope = ?", channel_name, params[:scope]);
      if (@channel.size == 0 || params[:receiver_id] == "0")
        @messages = []
        respond_to do |format|
          format.html
          format.json {render json: @messages}
        end
      else
        @messages = Message.where("channel_id = ?", @channel[0].id)
        json_to_return = {};
        json_to_return["messages"] = @messages;
        users = User.all;
        users_with_id = {};
        users_guild_with_id = {};
        users.each do |user|
          users_with_id[user.id] = user.name;
          if (user.guilds.first)
            users_guild_with_id[user.id] = user.guilds.first.anagram;
          else
            users_guild_with_id[user.id] = "";
          end
        end
        json_to_return["users"] = users_with_id;
        json_to_return["guilds"] = users_guild_with_id;
        respond_to do |format|
          format.html
          format.json {render json: json_to_return}
        end
      end
    else
      @messages = Message.where("channel_id = ?", params[:receiver_id]);
      json_to_return = {};
      json_to_return["messages"] = @messages;
      users = User.all;
      users_with_id = {};
      users_guild_with_id = {};
      users.each do |user|
        users_with_id[user.id] = user.name;
        if (user.guilds.first)
          users_guild_with_id[user.id] = user.guilds.first.anagram;
        else
          users_guild_with_id[user.id] = "";
        end
      end
      json_to_return["users"] = users_with_id;
      json_to_return["guilds"] = users_guild_with_id;
      respond_to do |format|
        format.html
        format.json {render json: json_to_return}
      end
    end
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    puts "here!"
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    puts params
    if params[:scope] == "direct"
      smaller = params[:user_id].to_i < params[:receiver_id].to_i ? params[:user_id] : params[:receiver_id];
      bigger = params[:user_id].to_i < params[:receiver_id].to_i ? params[:receiver_id] : params[:user_id];
      channel_name = "conversation_channel_" + smaller.to_s + "_" + bigger.to_s;
      channel = Channel.where("name = ? AND scope = ?", channel_name, params[:scope]).last;
      params[:message]["channel_id"] = channel.id;
      @message = Message.new(message_params);
      if (!@message.save)
        respond_to do |format|
          format.html
          format.json {render json: @message.errors, status: :unprocessable_entity}
        end
        return;
      end
      notif_channel = "notification_channel_" + params[:receiver_id].to_s;
      ActionCable.server.broadcast(notif_channel, {sender: channel})
      notif_channel = "notification_channel_" + params[:user_id].to_s;#pour update la page du sender aussi
      ActionCable.server.broadcast(notif_channel, {sender: channel});
    else
      # faire ici des check channelP ?
      channelP = Channel.find_by(id: params[:receiver_id]).channel_participations;
      current_channelP = channelP.find_by(user_id: params[:user_id]);
      if (current_channelP.status == "muted")
        datetime_now = Time.now;
        if (datetime_now < current_channelP.unmute_datetime)
          time_diff = current_channelP.unmute_datetime - datetime_now;
          hours = 0;
          minutes = 0;
          seconds = time_diff;
          if (seconds > 60 * 60)
            hours = (seconds / (60 * 60)).to_i;
            seconds = seconds - (hours * 60 * 60);
          end
          if (seconds > 60)
            minutes = (seconds / 60).to_i;
            seconds = seconds - (minutes * 60);
          end
          notif = {};
          notif["from_user_id"] = params[:user_id];
          notif["user_id"] = params[:user_id];
          notif["table_type"] = "information";
          notif["message"] = "you are muted for the next " + (hours > 0 ? (hours).to_s + " hours " : "") + (minutes > 0 ? (minutes).to_s + " minutes " : "") + (seconds > 0 ? (seconds).to_i.to_s + " seconds " : "");
          notif_to_save = Notification.new(notif);
          notif_to_save.save;
          ActionCable.server.broadcast("notification_channel_" + params[:user_id].to_s, {notification: "on"});
          return;
        else
          current_channelP.update(status: nil);
        end
      end
      params[:message]["channel_id"] = params[:receiver_id];#receiver ici c est la channel groupe
      @message = Message.new(message_params);
      if (!@message.save)
        respond_to do |format|
          format.html
          format.json {render json: @message.errors, status: :unprocessable_entity}
        end
        return;
      end
      channelP = Channel.find_by(id: params[:receiver_id]).channel_participations;
      channelP.each do |participant|
        ActionCable.server.broadcast("notification_channel_" + participant.user_id.to_s, {sender: Channel.find_by(id: params[:receiver_id])});
      end
      User.where("is_admin = ? OR is_owner = ?", true, true).each do |admin|
        ActionCable.server.broadcast("notification_channel_" + admin.id.to_s, {sender: Channel.find_by(id: params[:receiver_id])})
      end
    end
    # @message = Message.new(message_params)

    # respond_to do |format|
    #   if @message.save
    #     format.html { redirect_to @message, notice: 'Message was successfully created.' }
    #     format.json { render :show, status: :created, location: @message }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @message.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def message_params
      params.require(:message).permit(:user_id, :channel_id, :text)
    end
end
