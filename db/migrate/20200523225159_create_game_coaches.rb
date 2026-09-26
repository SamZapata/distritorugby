class CreateGameCoaches < ActiveRecord::Migration[5.2]
  def change
    create_table :game_coaches do |t|
      t.string :first_name
      t.string :last_name
      t.string :identification
      t.date :birthdate
      t.string :eps
      t.text :about
      t.string :phone
      t.string :email

      t.timestamps
    end
  end
end
