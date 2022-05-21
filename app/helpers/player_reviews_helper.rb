module PlayerReviewsHelper
  def review_submitted?(player, reviewer, reservation)
    PlayerReview.exists?(player: player, reviewer: reviewer, reservation: reservation)
  end
end
