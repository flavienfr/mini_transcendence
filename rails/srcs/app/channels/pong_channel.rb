class PongChannel < ApplicationCable::Channel
  def subscribed
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
        	winner_id = @state.to_user_id;
        else
        	winner_id = @state.from_user_id;
        end

        puts "-------------- set_end_game ---------------"
		@game.set_end_game({
			winner_id: winner_id,
			is_forfeit: true
		})
        puts "-------------- set_end_game ---------------"

      end
    end 
    # Any cleanup needed when channel is unsubscribed
   end
end
 