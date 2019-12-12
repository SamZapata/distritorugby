class CreateGameGoals < ActiveRecord::Migration[5.2]
  def change
    create_table :game_goals do |t|
      t.string :verb
      t.string :howdo
      t.string :moment
      t.string :forwhat

      t.timestamps
    end
  end
end
