class CreateGameClubTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :game_club_teams do |t|
      t.string :name
      t.text :about
      t.date :birthdate

      t.timestamps
    end
  end
end
