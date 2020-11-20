class StartTournamentJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    puts "STARTING TOURNAMENT";
    puts args[0].to_json;
    puts "--------------------";
    participations = TournamentParticipation.where("tournament_id = ?", args[0].id);
    puts participations.to_json;
    if (participations.size < 2 || participations.size > args[0].max_nb_player)
      return;#rajouter un table quand le tournoi demarre ? et mettre un affichage d erreur quand on peut pas demarrer ?
    end
    current_nb_of_player = participations.size;
    ref_nb = [16, 8, 4, 2];
    i = 0;
    ref_nb.each do |nb|
      if (current_nb_of_player > nb)
        break
      end
      i = i + 1;
    end
    cleaned_nb_of_player = ref_nb[i];
    nb_match_need = current_nb_of_player - cleaned_nb_of_player;
    puts current_nb_of_player;
    puts cleaned_nb_of_player;
    puts nb_match_need;
    i = 0;
    j = 0;
    while (i < nb_match_need)
      game = Game.create();
      gameP1 = GameParticipation.create(user_id: participations[j].user_id, game_id: game.id);
      gameP2 = GameParticipation.create(user_id: participations[j + 1].user_id, game_id: game.id);
      AskForGame.create(from_user_id: participations[j].user_id, to_user_id: participations[j + 1].user_id, status: "playing", game_type: "casual_match_making", game_id: game.id);
      ActionCable.server.broadcast("notification_channel_" + participations[j].user_id.to_s, {game: "on", content: "host_user"});
      ActionCable.server.broadcast("notification_channel_" + participations[j + 1].user_id.to_s, {game: "on", content: "guest_user"});
      j = j + 2;
      i = i + 1;
    end
  end
end
