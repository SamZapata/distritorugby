class AddColumnsToSlugs < ActiveRecord::Migration[5.2]
  def change
    add_column :news, :slug, :string
    add_column :stories, :slug, :string
    add_column :users, :slug, :string
    add_column :game_tournaments, :slug, :string
    add_column :game_unions, :slug, :string
    add_column :game_clubs, :slug, :string
    add_column :game_players, :slug, :string
    add_column :game_referees, :slug, :string
    add_column :game_coaches, :slug, :string
    add_column :game_matches, :slug, :string
  end
end
