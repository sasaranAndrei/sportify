json.extract! join_request, :id, :player_id, :reservation_id, :created_at, :updated_at
json.url join_request_url(join_request, format: :json)
