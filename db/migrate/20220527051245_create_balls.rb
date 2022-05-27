class CreateBalls < ActiveRecord::Migration[6.1]
  def change
    create_table :balls do |t|
      t.string :color
      t.references :player, null: false, foreign_key: true

      t.timestamps
    end
  end
end
