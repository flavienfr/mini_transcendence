class LandingController < ApplicationController

# @@current_user = 0

  def index
      if (current_user)
        @users = User.all
        
          #  @players = Player.all
            # @players.each do |player|
              # player.destroy
            # end
        
        # puts "------------a-----------"
        # @joignable_groups = Channel.where("scope = ? OR scope = ?", "public-group", "protected-group");
        # puts @joignable_groups.to_json;
        # @channel_participations = User.find_by(id: current_user.id).channel_participations;
        # puts @channel_participations.to_json;
        # @joignable_groups = @joignable_groups.where.not("id IN (?)", @channel_participations.pluck(:channel_id));
        # puts @joignable_groups.to_json;#a utiliser
        # @private_channels = Channel.where("scope = ?", "direct");
        # puts @private_channels.to_json;
        # @channel_participations = @channel_participations.where.not("channel_id IN (?)", @private_channels.pluck(:id));
        # puts @channel_participations.to_json;
        # @in_channels = Channel.where("id IN (?)", @channel_participations.pluck(:channel_id));
        # puts @in_channels.to_json;#a utiliser
        # puts "---------b---------"
      end
  end

  def update
  end


  def create
  end

  private

  def auth
  end
    
end
