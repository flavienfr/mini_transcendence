class TournamentParticipation < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :tournament, optional: true

  def state_of_tournament(tournament_participation, id_tournament, winner_part_id)
    puts "----------------------------CCCCCCCCCCCCCCCCCCC_________________"
    tournament_participation.update_tournament(winner_part_id)
  end

  def update_tournament(participation_id)
    puts "-----------------------AAAAAAAAAAAAAAAAAAAAAAAAAAAA_____________"
    tournament = TournamentParticipation.find(participation_id).tournament;
    puts tournament.to_json;
    if (tournament.max_nb_player == 1)
      tournament.update(status: "ended");
      winner = TournamentParticipation.where("nb_won_game = ? AND tournament_id = ?", tournament.step, tournament.id).first;
      puts "winner = " + User.find(winner.user_id).name.to_s;
      puts "end of tournament !"
      return ;
    end
    participations = TournamentParticipation.where("nb_won_game = ? AND tournament_id = ?", tournament.step, tournament.id);
    puts participations.to_json;
    if (participations.size == tournament.max_nb_player)
      i = 0;
      j = 0;
      nb_player = tournament.max_nb_player
      tournament.update(max_nb_player: tournament.max_nb_player / 2);
      tournament.update(step: tournament.step + 1);
      while ( i < (nb_player / 2))
        game = Game.create(tournament_id:  tournament.id, context: "tournament");
        gameP1 = GameParticipation.create(user_id: participations[j].user_id, game_id: game.id);
        gameP2 = GameParticipation.create(user_id: participations[j + 1].user_id, game_id: game.id);
        if (participations.first.is_already_playing(participations.first, participations[j].user_id,participations[j + 1].user_id, game) == false)
          AskForGame.create(from_user_id: participations[j].user_id, to_user_id: participations[j + 1].user_id, status: "playing", game_type: "Tournament", game_id: game.id);
          ActionCable.server.broadcast("notification_channel_" + participations[j].user_id.to_s, {game: "on", content: "host_user"});
          ActionCable.server.broadcast("notification_channel_" + participations[j + 1].user_id.to_s, {game: "on", content: "guest_user", host_id: participations[j].user_id});
        end
        j = j + 2;  
        i = i + 1;
      end
      # tournament.update(max_nb_player: tournament.max_nb_player / 2);
      # tournament.update(step: tournament.step + 1);
    end
  end

  def end_game(tournament_participation, user1, user2, game)
    part = TournamentParticipation.find_by(tournament_id: game.tournament_id, user_id: user1)
    puts "part1"
    puts part.to_json
    if (part.nb_lose_game == nil)
      part.update(nb_lose_game: 1);
    else
      part.update(nb_lose_game: part.nb_lose_game + 1)
    end
    part = TournamentParticipation.find_by(tournament_id: game.tournament_id, user_id: user2)
    if (part.nb_won_game == nil)
      part.update(nb_won_game: 1)
    else
      part.update(nb_won_game: part.nb_won_game + 1)
    end
    tournament_participation.update_tournament(part.id)
  end

  def is_already_playing(tournament_participation, user1, user2, game)
    puts "here david !"
    ask1 = AskForGame.find_by(from_user_id: user1, status: "playing");
    ask2 = AskForGame.find_by(from_user_id: user2, status: "playing");
    ask3 = AskForGame.find_by(to_user_id: user1, status: "playing");
    ask4 = AskForGame.find_by(to_user_id: user2, status: "playing");
    if (ask1 != nil)
      tournament_participation.end_game(tournament_participation, user1,user2, game)
      game.set_end_game({winner_id: user2, is_forfeit: true})
      return (true)
    elsif (ask2 != nil)
      tournament_participation.end_game(tournament_participation, user2, user1, game)
      game.set_end_game({winner_id: user1, is_forfeit: true})
      return (true)        
    elsif (ask3 != nil)
      tournament_participation.end_game(tournament_participation, user1,user2, game)
      game.set_end_game({winner_id: user2, is_forfeit: true})
      return (true)
    elsif (ask4 != nil)
      tournament_participation.end_game(tournament_participation, user2, user1, game)
      game.set_end_game({winner_id: user1, is_forfeit: true})
      return (true)        
    end 
    puts "return false"
    return false
  end

end
