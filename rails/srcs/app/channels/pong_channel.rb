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
        if (@state.status == "playing")
            ActionCable.server.broadcast("pong_channel_#{params[:pong_id]}", {data: "stop"});
            ActionCable.server.broadcast("pongnot_channel_#{0}", {data: "refresh"})
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
            @participant1 = TournamentParticipation.find_by(user_id: winner_id, tournament_id: @game.tournament_id)
            puts  @participant1.nb_won_game
            if (@participant1.nb_won_game == nil)
              @participant1.nb_won_game = 1;
            else
              @participant1.nb_won_game =   @participant1.nb_won_game + 1;
            end
            @participant1.save();
            @participant2 =  TournamentParticipation.find_by(user_id: looser_id, tournament_id: @game.tournament_id)
            if (@participant2.nb_lose_game == nil)
              @participant2.nb_lose_game = 1;
            else
              @participant2.nb_lose_game = @participant2.nb_lose_game + 1;
            end
            @participant2.save();
            puts "-----------------------------------BBBBBBBBBBBBBBB_________________"
            @participant1.state_of_tournament(@participant1, @game.tournament_id, @participant1.id)
          end
        end
      end 
    end
    # Any cleanup needed when channel is unsubscribed
   end
end
 