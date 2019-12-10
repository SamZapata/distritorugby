class RemoveFkFromTags < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :tags, :core_news
  end
end
