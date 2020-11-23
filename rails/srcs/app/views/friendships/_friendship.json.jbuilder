json.extract! friendship, :id, :status, :sender_id, :recipient_id, :created_at, :updated_at
json.url friendship_url(friendship, format: :json)
