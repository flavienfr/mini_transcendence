json.extract! game, :id, :start_date, :end_date, :context, :winner_id, :created_at, :updated_at
json.url game_url(game, format: :json)
