json.extract! session, :id, :token, :timeout, :user_id, :created_at, :updated_at
json.url session_url(session, format: :json)
