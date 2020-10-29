json.extract! war_participation, :id, :guild_id, :war_id, :war_points, :has_declared_war, :nb_unanswered_call, :is_winner, :status, :created_at, :updated_at
json.url war_participation_url(war_participation, format: :json)
