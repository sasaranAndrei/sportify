class AddJoinedByToReservationPlayers < ActiveRecord::Migration[6.1]
  def change
    add_column :reservation_players, :joined_by, :string
  end
end
