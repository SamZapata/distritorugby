class GamePlayerAddColumn < ActiveRecord::Migration[5.2]
  def change
    add_column :game_players, :club_team_id, :integer
  end
end
