class CreateTagsStories < ActiveRecord::Migration[5.2]
  def change
    create_table :tags_stories do |t|
      t.string :name
      t.integer :kind

      t.timestamps
    end
  end
end
