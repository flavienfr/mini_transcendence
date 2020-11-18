class Game < ApplicationRecord
    has_many :game_participations, dependent: :nullify
    has_many :users, :through => :game_participations
    belongs_to :channel, optional: true
    belongs_to :war, optional: true
    belongs_to :war_time, optional: true
	belongs_to :tournament, optional: true

	def set_end_game(params)
		puts "----------------- GameId: " + self.id.to_s
		puts "----------------- parmas: " + params.to_json

		# Utils variables
		war_duel_points = 100
		wartime_duel_points = 200
		player_winner = GameParticipation.where('game_id=? AND user_id=?', self.id, params[:winner_id]).first
		player_loser = GameParticipation.where('game_id=? AND user_id!=?', self.id, params[:winner_id]).first
		if (self.war_id != nil)
			war = War.where('id=?', self.war_id)
			guild_winner = player_winner.guild_participations.first.guild
			warp_winner = WarParticipation.where('war_id=? AND guild_id=?', war.id, guild_winner.id)
		end
		#--------------

		# Score and winner attribution
		player_winner.is_winner = true
		player_loser.is_winner = false
		if (params[:is_forfeit] == false)
			player_winner.score = params[:winner_score]
			player_loser.score = params[:loser_score]
		end
		self.update(
			end_date: Time.zone.now,
			winner_id: params[:winner_id], 
			status: "ending")
		player_winner.save
		player_loser.save
		#------------------------------

		# Game type management
		if (self.context == "war_duel")
			if (war.status != "ending")
				warp_winner.war_points += war_duel_points
			end
		elsif (self.context == "war_random_match")
			if (war.status != "ending")
				warp_winner.war_points += wartime_duel_points
			end
		elsif (self.context == "ladder_match_making")
			if (war != nil && war.count_all_matchs_for_war && war.status != "ending")
				warp_winner.war_points += war_duel_points
			end
		else
			return
		end
		warp_winner.save
	end

end