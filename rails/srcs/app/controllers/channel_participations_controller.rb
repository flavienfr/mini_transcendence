class ChannelParticipationsController < ApplicationController
  before_action :set_channel_participation, only: [:show, :edit, :update, :destroy]

  # GET /channel_participations
  # GET /channel_participations.json
  def index
    @channel_participations = ChannelParticipation.where("user_id = ? AND channel_id = ?", params[:user_id], params[:receiver_id])
    respond_to do |format|
      format.html
      format.json {render json: @channel_participations}
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
      channel_id = Channel.where("name = ? AND scope = ?", channel_name, params[:scope]).last.id;
      if (ChannelParticipation.where("user_id = ? AND channel_id = ?", params[:user_id], channel_id).size > 0)
        puts "channelP exist !"
      else
        puts "channelP doesnt exist"
        # channel_id = Channel.find_by(name: channel_name).id;
        @new_channelP = {};
        @new_channelP["user_id"] = params[:user_id];
        @new_channelP["channel_id"] = channel_id;
        puts @new_channelP;
        @new_channelP_to_save = ChannelParticipation.new(@new_channelP);
        @new_channelP_to_save.save;
        @new_channelP["user_id"] = params[:receiver_id];
        @new_channelP["channel_id"] = channel_id;
        @new_channelP_to_save = ChannelParticipation.new(@new_channelP);
        @new_channelP_to_save.save;
      end
    elsif (params[:scope] == "public-group" || params[:added])
      if (ChannelParticipation.where("user_id = ? AND channel_id = ?", params[:user_id], params[:receiver_id]).size == 0)
        channelP = {};
        channelP["user_id"] = params[:user_id];
        channelP["channel_id"] = params[:receiver_id];
        puts "a";
        puts channelP;
        puts "b";
        channelP_to_save = ChannelParticipation.new(channelP);
        channelP_to_save.save;
      end
    else
      if (params[:scope] == "protected-group" && Channel.find_by(id: params[:receiver_id]).password == params[:password])
        puts "ok password correct !"
        channelP = {};
        channelP["user_id"] = params[:user_id];
        channelP["channel_id"] = params[:receiver_id];
        channelP_to_save = ChannelParticipation.new(channelP);
        channelP_to_save.save;
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
    @channel_participation.destroy
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
      params.require(:channel_participation).permit(:user_id, :channel_id, :is_owner, :is_admin, :status)
    end
end
