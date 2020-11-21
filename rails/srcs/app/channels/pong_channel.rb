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
    if (@state != nil)
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
            looser_id = @state.from_user_id;
          else
            winner_id = @state.from_user_id;
            looser_id = @state.to_user_id;
          end
          puts "-------------- set_end_game ---------------"
          @game.set_end_game({
          winner_id: winner_id,
          is_forfeit: true
          })
          puts "-------------- set_end_game ---------------"
          if (@game.tournament_id != nil)
            @participant = TournamentParticipation.find_by(user_id: winner_id, tournament_id: @game.tournament_id)
            puts  @participant.nb_won_game
            if (@participant.nb_won_game == nil)
              @participant.nb_won_game = 1;
            else
              @participant.nb_won_game =   @participant.nb_won_game + 1;
            end
            @participant.save();
            @participant =  TournamentParticipation.find_by(user_id: looser_id, tournament_id: @game.tournament_id)
            if (@participant.nb_lose_game == nil)
              @participant.nb_lose_game = 1;
            else
              @participant.nb_lose_game = @participant.nb_lose_game + 1;
            end
            @participant.save();
          end
        end
      end 
    end
    # Any cleanup needed when channel is unsubscribed
   end
end
 