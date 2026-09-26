class AddImageCaptionToNews < ActiveRecord::Migration[5.2]
  def change
    add_column :news, :image_legend, :string, defaul: 'Add Legend'
    add_column :news, :video_legend, :string, defaul: 'Add Legend'
  end
end
