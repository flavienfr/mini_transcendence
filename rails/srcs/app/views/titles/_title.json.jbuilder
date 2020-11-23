json.extract! title, :id, :user_id, :tournament_id, :name, :status, :created_at, :updated_at
json.url title_url(title, format: :json)
