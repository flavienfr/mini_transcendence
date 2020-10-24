json.extract! guild_participation, :id, :user_id, :guild_id, :is_admin, :is_officer, :created_at, :updated_at
json.url guild_participation_url(guild_participation, format: :json)
