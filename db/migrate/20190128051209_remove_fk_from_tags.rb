class RemoveFkFromTags < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :tags, :news
  end
end
