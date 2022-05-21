json.extract! player_review, :id, :rating, :player_id, :reviewer_id, :reservation_id, :created_at, :updated_at
json.url player_review_url(player_review, format: :json)
