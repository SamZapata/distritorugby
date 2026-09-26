class CreateTagsStoryJoins < ActiveRecord::Migration[5.2]
  def change
    create_table :tags_story_joins do |t|
      t.belongs_to :story
      t.belongs_to :tags_story

      t.timestamps
    end
  end
end
