json.extract! message, :id, :user_id, :channel_id, :text, :created_at, :updated_at
json.url message_url(message, format: :json)
