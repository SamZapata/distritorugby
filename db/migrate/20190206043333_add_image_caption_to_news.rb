class AddImageCaptionToNews < ActiveRecord::Migration[5.2]
  def change
    add_column :core_news, :image_legend, :string, defaul: 'Add Legend'
    add_column :core_news, :video_legend, :string, defaul: 'Add Legend'
  end
end
