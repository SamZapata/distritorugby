class AddImageToNews < ActiveRecord::Migration[5.2]
  def change
    add_column :news, :image, :string, defaul: 'common/400x400.png'
  end
end
