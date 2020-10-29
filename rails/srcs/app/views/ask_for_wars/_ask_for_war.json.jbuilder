json.extract! ask_for_war, :id, :from_guild_id, :to_guild_id, :terms, :includes_ladder, :war_id, :status, :created_at, :updated_at
json.url ask_for_war_url(ask_for_war, format: :json)
