class AddLanLngToArena < ActiveRecord::Migration[6.1]
  def change
    add_column :arenas, :latitude, :decimal, default: 46.77017
    add_column :arenas, :longitude, :decimal, default: 23.59736
  end
end
