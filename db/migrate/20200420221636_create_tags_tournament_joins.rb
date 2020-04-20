class CreateTagsTournamentJoins < ActiveRecord::Migration[5.2]
  def change
    create_table :tags_tournament_joins do |t|
      t.integer :tournament_id
      t.integer :tags_tournament_id

      t.timestamps
    end
  end
end
