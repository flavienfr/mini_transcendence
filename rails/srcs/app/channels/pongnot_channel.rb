class PongnotChannel < ApplicationCable::Channel
  def subscribed
    puts("new subscribe")
    stream_from "pongnot_channel_#{params[:pong_id]}"
  end

  def receive(data)
  puts("reveive = ");
  puts (data);    
  ActionCable.server.broadcast("pongnot_channel_#{params[:pong_id]}", data);
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
