json.extract! notification, :id, :from_user_id, :to_user_id, :to_channel_id, :to_guild_id, :type, :message, :status, :created_at, :updated_at
json.url notification_url(notification, format: :json)
