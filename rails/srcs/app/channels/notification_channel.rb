class NotificationChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    puts "notification_channel_#{params[:room_id]}"
    stream_from "notification_channel_#{params[:room_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
