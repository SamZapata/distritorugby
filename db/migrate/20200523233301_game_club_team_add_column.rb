class GameClubTeamAddColumn < ActiveRecord::Migration[5.2]
  def change
    add_column :game_club_teams, :club_id, :integer
  end
end
