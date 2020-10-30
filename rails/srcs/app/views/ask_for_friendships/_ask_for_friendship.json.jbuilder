json.extract! ask_for_friendship, :id, :from_user_id, :to_user_id, :friendship_id, :status, :created_at, :updated_at
json.url ask_for_friendship_url(ask_for_friendship, format: :json)
