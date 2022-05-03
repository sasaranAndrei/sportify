class ChangePlayerToOwner < ActiveRecord::Migration[6.1]
  def change
    rename_column :reservations, :player_id, :owner_player_id
  end
end
