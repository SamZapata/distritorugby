class CreateGameTournamentGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :game_tournament_groups do |t|
      t.string :name
      t.integer :amount_teams
      t.bigint :game_tournament_id

      t.timestamps
    end
  end
end
