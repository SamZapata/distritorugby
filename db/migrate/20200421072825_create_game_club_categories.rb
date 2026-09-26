class CreateGameClubCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :game_club_categories do |t|
      t.string :name
      t.string :branch
      t.integer :club_id

      t.timestamps
    end
  end
end
