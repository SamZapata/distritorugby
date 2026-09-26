class CreateTagsNewsJoins < ActiveRecord::Migration[5.2]
  def change
    create_table :tags_news_joins do |t|
      t.belongs_to :news
      t.belongs_to :tags_news

      t.timestamps
    end
  end
end
