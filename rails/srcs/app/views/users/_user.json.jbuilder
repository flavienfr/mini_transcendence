json.extract! user, :id, :name, :avatar, :current_status, :points, :is_admin, :created_at, :updated_at
json.url user_url(user, format: :json)
