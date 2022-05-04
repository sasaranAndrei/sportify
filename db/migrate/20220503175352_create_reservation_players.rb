class CreateReservationPlayers < ActiveRecord::Migration[6.1]
  def change
    create_table :reservation_players do |t|
      t.references :reservation, null: false, foreign_key: true
      t.references :player, null: false, foreign_key: true

      t.timestamps
    end
  end
end
