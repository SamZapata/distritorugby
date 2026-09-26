class GamePlayerRenameColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :game_players, :weigth, :weight
  end
end
