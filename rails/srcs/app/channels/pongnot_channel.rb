class PongnotChannel < ApplicationCable::Channel
  def subscribed
    # puts "CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCOOOOOOOOOOOOOOOOOOO"
    puts params
    stream_from "pongnot_channel_#{params[:pong_id]}"
  end

  def receive(data)
    ActionCable.server.broadcast("pongnot_channel_#{params[:pong_id]}", data);
  end

  def unsubscribed
    # user = User.find(current_user.id)
    # user.current_status = "offline"
    # user.save
    # puts "JE SORS !"
    # Any cleanup needed when channel is unsubscribed
  end
end
