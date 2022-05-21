class FixReviewerColumn < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :player_reviews, :players, column: :reviewer_id
  end
end
