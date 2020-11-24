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
		puts "----------------------iiiiiiiiiiiiiiiiiiiiciciic-"

		# Utils variables
		war_duel_points = 100
		wartime_duel_points = 200
		gamep_winner = GameParticipation.where('game_id=? AND user_id=?', self.id, params[:winner_id]).first
		gamep_loser = GameParticipation.where('game_id=? AND user_id!=?', self.id, params[:winner_id]).first
		player_winner = User.find(params[:winner_id])
		if (player_winner.guild_participations.first)
			guild_winner = player_winner.guild_participations.first.guild
		end
		if (self.war_id != nil)
			war = War.find(self.war_id)
			warp_winner = WarParticipation.where('war_id=? AND guild_id=?', war.id, guild_winner.id).first
		end
		#--------------
		# Score and winner attribution
		gamep_winner.is_winner = true
		gamep_loser.is_winner = false
		if (params[:is_forfeit] == false)
			gamep_winner.score = params[:winner_score]
			gamep_loser.score = params[:loser_score]
		end

		self.update(
			end_date: Time.zone.now,
			winner_id: params[:winner_id], 
			status: "ending"
		)
		gamep_winner.save
		gamep_loser.save

		if (player_winner.guild_participations.first)
			guild_winner.points += 10
			guild_winner.save
		end
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
		elsif (self.context == "ranked_match_making")
			if (war != nil && war.count_all_matchs_for_war && war.status != "ending")
				warp_winner.war_points += war_duel_points
			end
			if (gamep_winner.score != nil && gamep_loser.score != nil)
				lad = gamep_winner.score - gamep_loser.score
			else
				lad = 1
			end	
			player_winner.points = player_winner.points + lad * 10
			player_winner.save
		elsif (self.context == "casual_match_making")
			if (war != nil && war.count_all_matchs_for_war && war.status != "ending")
				warp_winner.war_points += war_duel_points
			end
		elsif (self.context == "tournament")#a tester
			if (war != nil && war.count_all_matchs_for_war && war.status != "ending")
				warp_winner.war_points += war_duel_points
			end
		else
			return
		end

		if (warp_winner != nil)
			warp_winner.save()
		end 
	end
end