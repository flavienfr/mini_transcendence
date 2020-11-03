json.extract! tournament_participation, :id, :user_id, :tournament_id, :status, :score, :nb_won_game, :nb_lose_game, :created_at, :updated_at
json.url tournament_participation_url(tournament_participation, format: :json)
