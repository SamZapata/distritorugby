class CreateGameClubCoachJoins < ActiveRecord::Migration[5.2]
  def change
    create_table :game_club_coach_joins do |t|
      t.integer :club_id
      t.integer :coach_id
      t.string :role
      t.string :state

      t.timestamps
    end
  end
end
