json.extract! guild, :id, :name, :anagram, :points, :is_making_war, :owner_id, :created_at, :updated_at
json.url guild_url(guild, format: :json)
