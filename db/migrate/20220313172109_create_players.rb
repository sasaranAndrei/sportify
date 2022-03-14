# frozen_string_literal: true

class CreatePlayers < ActiveRecord::Migration[6.1]
  def change
    create_table :players do |t|
      t.string :name
      t.string :nickname
      t.date :birth_date
      t.string :phone_number
      t.date :joined_at
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
