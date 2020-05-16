class TournamentGroupChangeColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :game_tournament_groups, :game_tournament_id, :tournament_id
  end
end
