class CreateCoreStories < ActiveRecord::Migration[5.2]
  def change
    create_table :core_stories do |t|
      t.string :name
      t.string :phrase
      t.text :intro
      t.text :body
      t.datetime :birthdate
      t.datetime :deathdate
      t.string :image
      t.string :img_caption
      t.string :emb_video
      t.string :video_caption
      t.string :socialmedia, array: true

      t.timestamps
    end
  end
end
