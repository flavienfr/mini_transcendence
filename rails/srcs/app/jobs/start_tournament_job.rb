class StartTournamentJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    puts "STARTING TOURNAMENT";
    puts args[0].to_json;
    puts "--------------------";
    participations = TournamentParticipation.where("tournament_id = ?", args[0].id).order("created_at");
    puts participations.to_json;
    if (participations.size < 2 || participations.size > args[0].max_nb_player)
      Tournament.find_by(id: args[0].id).update(status: "ended");#gagne incentive par default ?
      return;#rajouter un table quand le tournoi demarre ? et mettre un affichage d erreur quand on peut pas demarrer ?
    end
    current_nb_of_player = participations.size;
    ref_nb = [16, 8, 4, 2];
    i = 0;
    ref_nb.each do |nb|
      if (current_nb_of_player >= nb)
        break
      end
      i = i + 1;
    end
    puts "i = "  + i.to_s;
    puts "current nb player = " + current_nb_of_player.to_s;
    cleaned_nb_of_player = ref_nb[i];
    nb_match_need = current_nb_of_player - cleaned_nb_of_player;
    puts current_nb_of_player;
    puts cleaned_nb_of_player;
    puts nb_match_need;
    i = 0;
    j = 0;
    k = 0;
    args[0].update(max_nb_player: cleaned_nb_of_player, step: 1, status: "started");
    k = nb_match_need * 2;
    while (k < current_nb_of_player)
      participations[k].update(nb_won_game: 1);
      k = k + 1;
    end
    while (i < nb_match_need)
      game = Game.create(tournament_id:  args[0].id, context: "tournament");
      gameP1 = GameParticipation.create(user_id: participations[j].user_id, game_id: game.id);
      gameP2 = GameParticipation.create(user_id: participations[j + 1].user_id, game_id: game.id);
      if (participations.first.is_already_playing(participations.first, participations[j].user_id,participations[j + 1].user_id, game) == false)
        AskForGame.create(from_user_id: participations[j].user_id, to_user_id: participations[j + 1].user_id, status: "playing", game_type: "Tournament", game_id: game.id);
        ActionCable.server.broadcast("notification_channel_" + participations[j].user_id.to_s, {game: "on", content: "host_user", tournament_id:  args[0].id});
        ActionCable.server.broadcast("notification_channel_" + participations[j + 1].user_id.to_s, {game: "on", content: "guest_user", host_id: participations[j].user_id});
      end 
      j = j + 2;
      i = i + 1;
    end
    # while (j < current_nb_of_player)
    #   participations[j].update(nb_won_game: 1);
    #   j = j + 1;
    # end
    # args[0].update(max_nb_player: cleaned_nb_of_player);
    # args[0].update(step: 1);
    if (nb_match_need == 0)
      tournament = args[0];
      participations = TournamentParticipation.where("nb_won_game = ? AND tournament_id = ?", tournament.step, tournament.id).order("created_at");
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
            ActionCable.server.broadcast("notification_channel_" + participations[j].user_id.to_s, {game: "on", content: "host_user", tournament_id: tournament.id});
            ActionCable.server.broadcast("notification_channel_" + participations[j + 1].user_id.to_s, {game: "on", content: "guest_user", host_id: participations[j].user_id});
          end
          j = j + 2;  
          i = i + 1;
        end
        # tournament.update(max_nb_player: tournament.max_nb_player / 2);
        # tournament.update(step: tournament.step + 1);
      end 
    end
  end
end
