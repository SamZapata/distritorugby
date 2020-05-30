class GameClubTeamAddColumns < ActiveRecord::Migration[5.2]
  def change
    add_column :game_club_teams, :mode, :integer
    add_column :game_club_teams, :club_category_id, :integer
  end
end
