class CreateStories < ActiveRecord::Migration[5.2]
  def change
    create_table :stories do |t|
      t.string :name
      t.text :description
      t.string :emb_video
      t.string :video_caption
      t.string :image
      t.string :img_caption

      t.timestamps
    end
  end
end
