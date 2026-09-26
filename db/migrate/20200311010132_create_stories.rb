class CreateStories < ActiveRecord::Migration[5.2]
  def change
    create_table :stories do |t|
      t.string :name
      t.string :summary
      t.text :body
      t.string :emb_video
      t.string :image
      t.string :image_caption
      t.string :video_caption

      t.timestamps
    end
  end
end
