class GameClubAddColumns < ActiveRecord::Migration[5.2]
  def change
    add_column :game_clubs, :address, :string
    add_column :game_clubs, :logo, :string
    add_column :game_clubs, :alias, :string
  end
end
