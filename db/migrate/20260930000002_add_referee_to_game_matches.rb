class AddRefereeToGameMatches < ActiveRecord::Migration[7.1]
  def change
    add_reference :game_matches, :referee, foreign_key: { to_table: :game_referees }
  end
end
