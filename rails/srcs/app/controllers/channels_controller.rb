class ChannelsController < ApplicationController
  before_action :set_channel, only: [:show, :edit, :update, :destroy]

  # GET /channels
  # GET /channels.json
  def index
    # @channels = Channel.all
    puts "------------a-----------"
    joignable_groups = Channel.where("scope = ? OR scope = ?", "public-group", "protected-group");
    puts joignable_groups.to_json;
    channel_participations = User.find_by(id: current_user.id).channel_participations;
    puts channel_participations.to_json;
    if (channel_participations.size > 0)
      joignable_groups = joignable_groups.where.not("id IN (?)", channel_participations.pluck(:channel_id));
    end
    puts joignable_groups.to_json;#a utiliser
    private_channels = Channel.where("scope = ?", "private-direct");#pour enlever les messages directs
    puts private_channels.to_json;
    if (private_channels.size > 0)
      channel_participations = channel_participations.where.not("channel_id IN (?)", private_channels.pluck(:id));
    end
    puts channel_participations.to_json;
    in_channels = Channel.where("id IN (?)", channel_participations.pluck(:channel_id));
    puts in_channels.to_json;#a utiliser
    puts "---------b---------"
    json_to_return = {};
    json_to_return["users"] = User.all;
    json_to_return["channels_joignable"] = joignable_groups;
    json_to_return["channels_in"] = in_channels;
    respond_to do |format|
      format.html
      format.json {render json: json_to_return}
    end
  end

  # GET /channels/1
  # GET /channels/1.json
  def show
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
    puts params
    @new_channel = {};
    @new_channel["name"] = params[:name];
    @new_channel["scope"] = params[:scope];
    @new_channel["owner_id"] = params[:owner_id];
    if (params[:password])
      @new_channel["password"] = params[:password];
    end
    puts @new_channel;
    @new_channel_to_save = Channel.new(@new_channel);
    @new_channel_to_save.save;
    @new_channelP = {};
    @new_channelP["user_id"] = params[:owner_id];
    @new_channelP["channel_id"] = @new_channel_to_save.id;
    @new_channelP_to_save = ChannelParticipation.new(@new_channelP);
    @new_channelP_to_save.save;
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
    respond_to do |format|
      if @channel.update(channel_params)
        format.html { redirect_to @channel, notice: 'Channel was successfully updated.' }
        format.json { render :show, status: :ok, location: @channel }
      else
        format.html { render :edit }
        format.json { render json: @channel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /channels/1
  # DELETE /channels/1.json
  def destroy
    @channel.destroy
    respond_to do |format|
      format.html { redirect_to channels_url, notice: 'Channel was successfully destroyed.' }
      format.json { head :no_content }
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
