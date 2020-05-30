class CreateGamePlayerCteamJoins < ActiveRecord::Migration[5.2]
  def change
    create_table :game_player_cteam_joins do |t|
      t.integer :club_team_id
      t.integer :player_id
      t.string :role

      t.timestamps
    end
  end
end
