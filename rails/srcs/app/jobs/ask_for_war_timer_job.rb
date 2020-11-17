class AskForWarTimerJob < ApplicationJob
  queue_as :default

  def perform(ask_for_war_id, war_time_id, warp_a_id, warp_b_id)
	@ask_for_game = AskForGame.find(ask_for_war_id)
	@war_time = WarTime.find(war_time_id)
	@warp_a = WarParticipation.find(warp_a_id)
	@warp_b = WarParticipation.find(warp_b_id)
	to_guild_id = @warp_b.guild_id
	from_guild_id = @ask_for_game.to_user_id

	if (@ask_for_game.status == "pending")
		@ask_for_game.update( status: "ending" )

		if (@war_time.a == to_guild_id)
			@war_time.nb_unanswered_call_a += 1
		else
			@war_time.nb_unanswered_call_b += 1
		end
		@war_time.save

		@warp_a.war_points += 200
		@warp_a.save
		#envoyé une notif match gagné en bonus
	end
  end
end

# examples

# wait: x.time for now
  # AskForWarTimerJob.set(wait: 2.seconds).perform_later(1)
  # AskForWarTimerJob.set(wait: 2.hours).perform_later(1)

# wait_until: Date.tomorrow.noon
