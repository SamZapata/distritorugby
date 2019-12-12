class CreateGameEquipment < ActiveRecord::Migration[5.2]
  def change
    create_table :game_equipment do |t|
      t.string :name
      t.integer :type

      t.timestamps
    end
  end
end
