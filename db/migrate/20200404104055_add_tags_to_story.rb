class AddTagsToStory < ActiveRecord::Migration[5.2]
  def change
    add_column :stories, :tags, :text, array: true, default: []
  end
end
