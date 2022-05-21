class CreatePlayerReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :player_reviews do |t|
      t.integer :rating
      t.references :player, null: false, foreign_key: true
      t.references :reviewer, null: false
      t.references :reservation, null: false, foreign_key: true

      t.timestamps
    end

  end
end
