class CreateGameUnions < ActiveRecord::Migration[5.2]
  def change
    create_table :game_unions do |t|
      t.string :name
      t.text :about
      t.date :founded
      t.string :website
      t.string :logo
      t.string :country
      t.string :abbr

      t.timestamps
    end
  end
end
