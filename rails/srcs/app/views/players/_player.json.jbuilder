json.extract! player, :id, :user_id, :created_at, :updated_at, :game_type
json.url player_url(player, format: :json)
