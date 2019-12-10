class AddImageToNews < ActiveRecord::Migration[5.2]
  def change
    add_column :core_news, :image, :string #, defaul: 'common/400x400.png'
  end
end
