class CreateGameTournaments < ActiveRecord::Migration[5.2]
  def change
    create_table :game_tournaments do |t|
      t.string :name
      t.date :start_date
      t.date :end_date
      t.text :about
      t.string :country
      t.string :region
      t.string :city
      t.string :organizer

      t.timestamps
    end
  end
end
