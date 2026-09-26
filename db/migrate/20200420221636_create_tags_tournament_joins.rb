class CreateTagsTournamentJoins < ActiveRecord::Migration[5.2]
  def change
    create_table :tags_tournament_joins do |t|
      t.belongs_to :game_tournament
      t.belongs_to :tags_tournament

      t.timestamps
    end
  end
end
