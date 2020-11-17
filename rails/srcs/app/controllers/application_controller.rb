class ApplicationController < ActionController::Base
	helper_method :current_user
	
	#@toto = "le gros bide"

    def current_user

        puts "ApplicationController::current_user()"
        # if cookies.signed[:id]
        # if 3
        if cookies.signed[:id]
            puts "existing cookies.signed[:id]"
            # cookies.permanent.signed[:id] = 3#enregistre le id
            @current_user = User.find(cookies.signed[:id])#cookies a delete apres logout out timeout sinon soucis de cookies deja disponible
            #il faudra rajouter un moyen pour logout quand session plus valide timeout ? meme si c est pas grave
        elsif params[:type]
            puts "OK                        aaaaaaaaaaa"
            @current_user = User.find(2);
            session = Session.new()
            session.user_id = @current_user.id
            cookies.permanent.signed[:id] = session.user_id
            session.save
        else
            puts "no cookies.signed[:id]"
            @current_user = nil
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
end
