class CreateGamePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :game_players do |t|
      t.string :first_name
      t.string :last_name
      t.string :identification
      t.date :birthdate
      t.string :eps
      t.float :weigth
      t.float :height
      t.string :position
      t.string :phone
      t.string :injuries
      t.text :about
      t.string :email

      t.timestamps
    end
  end
end
