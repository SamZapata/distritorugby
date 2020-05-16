class CreateGameClubMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :game_club_matches do |t|
      t.integer :club_id
      t.integer :match_id

      t.timestamps
    end
  end
end
