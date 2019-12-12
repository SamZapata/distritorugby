class CreateGameDrills < ActiveRecord::Migration[5.2]
  def change
    create_table :game_drills do |t|
      t.string :name
      t.text :description
      t.string :figure
      t.string :video_emb
      t.string :time
      t.string :image
      t.string :video_emb

      t.timestamps
    end
  end
end
