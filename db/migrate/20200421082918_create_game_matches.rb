class CreateGameMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :game_matches do |t|
      t.date :play_date
      t.time :play_time
      t.string :emb_location
      t.string :address

      t.timestamps
    end
  end
end
