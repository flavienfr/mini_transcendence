json.extract! channel, :id, :name, :scope, :password, :owner_id, :created_at, :updated_at
json.url channel_url(channel, format: :json)
