class ApplicationController < ActionController::Base
	helper_method :current_user
	
    def current_user

        puts "inside applicationController#current_user"
        if cookies.signed[:id]
            # find current_user
            puts "existing cookies.signed[:id]"
            @current_user = User.find_by(id: cookies.signed[:id])
        elsif params[:type]
            puts "OK                        aaaaaaaaaaa"
            @current_user = User.find(2);
            session = Session.new()
            session.user_id = @current_user.id
            cookies.permanent.signed[:id] = session.user_id
            session.save
        else
            # ?
            puts "no cookies.signed[:id]"
            @current_user = nil
            # redirect_to root_path
        end
	end

	def send_notification(from_user_id, to_user_id, table_type, table_id, message, status)
		@notification = Notification.new(
		  from_user_id: from_user_id,
		  user_id: to_user_id,
		  table_type: table_type,
		  table_id: table_id,
		  message: message,
		  status: status
		)
		@notification.save

		puts "----- notification ----"
		puts @notification.to_json
		puts "-----------------------"

		notif_channel = "notification_channel_" + to_user_id.to_s;
		ActionCable.server.broadcast(notif_channel, {notification: "On"})
    end
    
    def user_is_admin_owner?
        user = User.find(current_user.id);
        user.is_owner || user.is_admin
    end

    def user_is_current_guild_participant?(guild_participation_id)
        GuildParticipation.find_by(id: guild_participation_id).user_id == current_user.id
    end

    def user_is_guild_admin?(guild_id)
        guildP = GuildParticipation.find_by(guild_id: guild_id, user_id: current_user.id)
        if guildP
            guildP.is_admin
        end
    end

    def user_is_guild_officer?(guild_id)
        guildP = GuildParticipation.find_by(guild_id: guild_id, user_id: current_user.id)
        if guildP
            guildP.is_officer
        end
    end

    def user_is_channel_participant?(channel_id)
        ChannelParticipation.find_by(channel_id: channel_id, user_id: current_user.id)
    end

    def user_is_current_channel_participant?(channel_participation_id)
        ChannelParticipation.find_by(id: channel_participation_id).user_id == current_user.id
    end

    def user_is_channel_owner?(channel_id)
        channelP = ChannelParticipation.find_by(channel_id: channel_id, user_id: current_user.id)
        if channelP
            channelP.is_owner
        end
    end

    def user_is_channel_admin?(channel_id)
        channelP = ChannelParticipation.find_by(channel_id: channel_id, user_id: current_user.id)
        if channelP
            channelP.is_admin
        end
    end
end
