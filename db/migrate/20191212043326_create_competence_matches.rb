class CreateCompetenceMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :competence_matches do |t|
      t.string :name
      t.string :team1
      t.string :team2
      t.datetime :play_date
      t.string :referee
      t.string :field

      t.timestamps
    end
  end
end
