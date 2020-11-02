class PongnotChannel < ApplicationCable::Channel
  def subscribed
    stream_from "pongnot_channel_#{params[:pong_id]}"
  end

  def receive(data)
    ActionCable.server.broadcast("pongnot_channel_#{params[:pong_id]}", data);
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
