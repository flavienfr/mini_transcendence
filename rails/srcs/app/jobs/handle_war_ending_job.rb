class HandleWarEndingJob < ApplicationJob
  queue_as :default

  def perform(war_id)
	war = War.find(war_id)
	puts "-------------------- IN war id= " + war.id.to_s + " heure: " + Time.zone.now.to_s

	#Variable utils
	the_war = War.find(war_id)
	warp_a = WarParticipation.where('war_id=?', the_war.id).first
	warp_b = WarParticipation.where('war_id=?', the_war.id).last
	guild_a = Guild.find(warp_a.guild_id)
	guild_b = Guild.find(warp_b.guild_id)

	#puts "Time.zone.now > the_war.end_date", Time.zone.now, the_war.end_date
	#if (Time.zone.now > the_war.end_date)
	puts "warp_a.war_points > warp_b.war_points", warp_a.war_points, warp_b.war_points
	if (warp_a.war_points > warp_b.war_points)
		warp_a.is_winner = true
		warp_b.is_winner = false
		the_war.winner_id = guild_a.id
		guild_a.points += the_war.prize_in_points
		guild_b.points -= the_war.prize_in_points
	elsif (warp_a.war_points < warp_b.war_points)
		warp_a.is_winner = false
		warp_b.is_winner = true
		the_war.winner_id = guild_b.id
		guild_b.points += the_war.prize_in_points
		guild_a.points -= the_war.prize_in_points
	else
		warp_a.is_winner = nil
		warp_b.is_winner = nil
		the_war.winner_id = nil
	end
	#guild_a
	guild_a.war_participation_id = nil
	guild_a.is_making_war = false
	warp_a.status = "ending"
	guild_a.save
	warp_a.save

	#guild_b
	guild_b.war_participation_id = nil
	guild_b.is_making_war = false
	warp_b.status = "ending"
	guild_b.save
	warp_b.save

	the_war.status = "ending"
	the_war.save

	#TO DO: envoyer une notif de fin de guerre
  end
end

# HandleWarEndingJob.set(wait_until: the_war.end_date).perform_later(1)