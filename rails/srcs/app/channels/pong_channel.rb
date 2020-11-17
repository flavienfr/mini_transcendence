class PongChannel < ApplicationCable::Channel
  def subscribed
    puts "IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII" 
    stream_from "pong_channel_#{params[:pong_id]}"
   end
 
   def receive(data)
     ActionCable.server.broadcast("pong_channel_#{params[:pong_id]}", data)
    end
 
   def unsubscribed
    puts "&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&"
    puts params
    puts "&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&"
    @state = AskForGame.find_by(from_user_id: params[:pong_id], status: "playing")
    if (params[:user_id] == @state.from_user_id || params[:user_id] == @state.to_user_id)
      ActionCable.server.broadcast("pongnot_channel_#{0}", {data: "refresh"})
      ActionCable.server.broadcast("pong_channel_#{params[:pong_id]}", {data: "stop"});
      if (@state.status == "playing")
        puts "+++++++++++++++++++++++++++++++++++++++++++++++"
        puts params
        @state.status = "ending";
        @state.save;
        @game = Game.find(@state.game_id);
        if (params[:user_id] == @state.from_user_id)
          @game.update(
            winner_id: @state.to_user_id, 
            forfeit: true)
        else
          @game.update(
            winner_id: @state.from_user_id,
            forfeit: true)        
        end 
      end
    end 
    # Any cleanup needed when channel is unsubscribed
   end
end
 