class CreateCompetenceTournaments < ActiveRecord::Migration[5.2]
  def change
    create_table :competence_tournaments do |t|
      t.string :name

      t.timestamps
    end
  end
end
