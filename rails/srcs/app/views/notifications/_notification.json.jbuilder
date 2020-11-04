json.extract! notification, :id, :from_user_id, :user_id, :to_channel_id, :to_guild_id, :table_type, :message, :status, :created_at, :updated_at
json.url notification_url(notification, format: :json)
