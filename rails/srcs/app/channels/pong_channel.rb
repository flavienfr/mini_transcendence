class PongChannel < ApplicationCable::Channel
  def subscribed
     stream_from "pong_channel_#{1}"
   end
 
   def receive(data)
     ActionCable.server.broadcast("pong_channel_#{1}", data)
   end
 
   def unsubscribed
     # Any cleanup needed when channel is unsubscribed
   end
 end
 