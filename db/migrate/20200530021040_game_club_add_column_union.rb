class GameClubAddColumnUnion < ActiveRecord::Migration[5.2]
  def change
    add_column :game_clubs, :union_id, :integer
  end
end
