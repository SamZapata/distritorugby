class AddFieldsToCoreStory < ActiveRecord::Migration[5.2]
  def change
    add_column :core_stories, :birthdate, :datetime
    add_column :core_stories, :deathdate, :datetime
    add_column :core_stories, :phrase, :string
    add_column :core_stories, :intro, :string
    add_column :core_stories, :socialmedia, :string, array: true, default: []
  end
end
