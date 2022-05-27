class CreateTshirts < ActiveRecord::Migration[6.1]
  def change
    create_table :tshirts do |t|
      t.integer :number
      t.string :nickname
      t.string :color
      t.string :size
      t.references :player, null: false, foreign_key: true

      t.timestamps
    end
  end
end
