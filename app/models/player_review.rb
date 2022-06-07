class PlayerReview < ApplicationRecord
  belongs_to :player
  belongs_to :reviewer, class_name: 'Player'
  belongs_to :reservation

  RATING_MIN = 1
  RATING_MAX = 5

  # TODO: TechQuestion8? How to move review_submitted? method here (maybe as a static method).
  # move that method here
  
end
