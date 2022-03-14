class CreateArenas < ActiveRecord::Migration[6.1]
  def change
    create_table :arenas do |t|
      t.string :title
      t.string :location
      t.string :phone_number

      t.timestamps
    end
  end
end
