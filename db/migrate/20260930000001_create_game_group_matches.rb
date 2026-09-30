class CreateGameGroupMatches < ActiveRecord::Migration[7.1]
  def change
    create_table :game_group_matches do |t|
      t.references :group, null: false, foreign_key: { to_table: :game_tournament_groups }
      t.references :match, null: false, foreign_key: { to_table: :game_matches }
      t.timestamps
    end

    add_index :game_group_matches, %i[group_id match_id], unique: true
  end
end
