class AddFkToTag < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :tags, :news, column: :news_id
  end
end
