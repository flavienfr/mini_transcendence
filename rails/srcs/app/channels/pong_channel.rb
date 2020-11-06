class PongChannel < ApplicationCable::Channel
  def subscribed
     stream_from "pong_channel_#{params[:pong_id]}"
   end
 
   def receive(data)
     ActionCable.server.broadcast("pong_channel_#{params[:pong_id]}", data)
   end
 
   def unsubscribed
     # Any cleanup needed when channel is unsubscribed
   end
 end
 