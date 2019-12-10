class CreateCoreNews < ActiveRecord::Migration[5.2]
  def change
    create_table :core_news do |t|
      t.string :title
      t.text :summary
      t.string :image
      t.string :image_legend
      t.string :emb_video
      t.string :video_legend
      t.text :body

      t.timestamps
    end
  end
end
