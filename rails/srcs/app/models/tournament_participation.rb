class TournamentParticipation < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :tournament, optional: true

  def update_state_tournament
    tournament = TournamentParticipation.find(participation_id).tournament;
    puts tournament.to_json;
    if (tournament.max_nb_player == 1)
      winner = TournamentParticipation.where("nb_won_game = ? AND tournament_id = ?", tournament.step, tournament.id).first;
      puts "winner = " + User.find(winner.user_id).name.to_s;
      puts "end of tournament !"
      return ;
    end
    participations = TournamentParticipation.where("nb_won_game = ? AND tournament_id = ?", tournament.step, tournament.id);
    puts participations.to_json;
    puts "dehors de la condition"
    puts participations.size
    puts tournament.max_nb_player
    if (participations.size == tournament.max_nb_player) 
      puts  "dans la condition"
      i = 0;
      j = 0;
      nb_player = tournament.max_nb_player
      tournament.update(max_nb_player: tournament.max_nb_player / 2);
      tournament.update(step: tournament.step + 1);
      while ( i < (nb_player / 2))
        game = Game.create(tournament_id:  tournament.id);
        gameP1 = GameParticipation.create(user_id: participations[j].user_id, game_id: game.id);
        gameP2 = GameParticipation.create(user_id: participations[j + 1].user_id, game_id: game.id);
        if (is_already_playing(participations[j].user_id,participations[j + 1].user_id, game) == false)
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

  def state_of_tournament(id_tournament, winner_part_id)
    update_tournament(winner_part_id)
    tournament = Tournament.find(id_tournament);
    if (tournament.max_nb_player == 1)
      winner = TournamentParticipation.where("nb_won_game = ? AND tournament_id = ?", tournament.step, tournament.id).first;
      puts "winner = " + User.find(winner.user_id).name.to_s;
      puts "end of tournament !"
      return ;
    end

  end
end
