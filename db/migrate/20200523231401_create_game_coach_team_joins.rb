class CreateGameCoachTeamJoins < ActiveRecord::Migration[5.2]
  def change
    create_table :game_coach_team_joins do |t|
      t.integer :club_team_id
      t.integer :coach_id
      t.string :role

      t.timestamps
    end
  end
end
