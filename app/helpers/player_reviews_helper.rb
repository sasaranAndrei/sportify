module PlayerReviewsHelper
  def review_submitted?(player, reviewer_player, reservation)
    PlayerReview.exists?(player: player, reviewer: reviewer_player, reservation: reservation)
  end

  def should_display_review_buttons?(player, reviewer_player, reservation)
    reservation.has_passed? &&
      !(player == reviewer_player) && 
      !review_submitted?(player, reviewer_player, reservation)
  end
end



















# passed  equal  submitted  should_display_review_buttons?
# 0         0       0           0
# 0         0       1           0
# 0         1       0           0
# 0         1       1           0
# 1         0       0           1
# 1         0       1           0
# 1         1       0           0
# 1         1       1           0
