class PongChannel < ApplicationCable::Channel
  def subscribed
     stream_from "pong_channel_#{params[:pong_id]}"
   end
 
   def receive(data)
     ActionCable.server.broadcast("pong_channel_#{params[:pong_id]}", data)
    end
 
   def unsubscribed
    puts "&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&"
    ActionCable.server.broadcast("pongnot_channel_#{0}", {data: "refresh"})
    @state = AskForGame.find_by(from_user_id: params[:pong_id], status: "playing")
    @state.status = "ending";
    @state.save;
    
    # Any cleanup needed when channel is unsubscribed
   end
 end
 