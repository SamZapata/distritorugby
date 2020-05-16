class CreateGameClubs < ActiveRecord::Migration[5.2]
  def change
    create_table :game_clubs do |t|
      t.string :name
      t.text :about
      t.string :picture
      t.string :emb_location
      t.string :phone
      t.string :email
      t.string :webpage
      t.string :instagram
      t.string :facebook
      t.string :twitter
      t.string :youtube

      t.timestamps
    end
  end
end
