class RemoveJoinedAtFromPlayers < ActiveRecord::Migration[6.1]
  def change
    remove_column :players, :joined_at
  end
end
