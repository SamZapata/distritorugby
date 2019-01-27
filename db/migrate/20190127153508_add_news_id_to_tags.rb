class AddNewsIdToTags < ActiveRecord::Migration[5.2]
  def change
    add_column :tags, :news_id, :integer
  end
end
