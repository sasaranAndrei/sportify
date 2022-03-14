class CreateFields < ActiveRecord::Migration[6.1]
  def change
    create_table :fields do |t|
      t.references :arena, null: false, foreign_key: true
      t.references :sport, null: false, foreign_key: true
      t.string :label
      t.integer :min_players
      t.integer :max_players

      t.timestamps
    end
  end
end
