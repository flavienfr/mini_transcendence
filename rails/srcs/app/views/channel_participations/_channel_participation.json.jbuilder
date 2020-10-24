json.extract! channel_participation, :id, :user_id, :channel_id, :is_owner, :is_admin, :status, :created_at, :updated_at
json.url channel_participation_url(channel_participation, format: :json)
