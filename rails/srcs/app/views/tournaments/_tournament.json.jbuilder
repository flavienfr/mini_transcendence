json.extract! tournament, :id, :rules, :incentives, :status, :deadline, :created_at, :updated_at
json.url tournament_url(tournament, format: :json)
