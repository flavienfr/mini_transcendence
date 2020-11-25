class NotificationChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    puts "notification_channel_#{params[:room_id]}"
    stream_from "notification_channel_#{params[:room_id]}"
  end

  def unsubscribed
    user = User.find(params[:room_id].to_i)
    if (user.current_status == "logged in")
      user.current_status = "offline"
      user.save
    end
    # Any cleanup needed when channel is unsubscribed
  end
end
