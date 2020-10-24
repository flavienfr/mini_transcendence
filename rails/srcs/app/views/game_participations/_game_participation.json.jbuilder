json.extract! game_participation, :id, :user_id, :game_id, :score, :is_winner, :created_at, :updated_at
json.url game_participation_url(game_participation, format: :json)
