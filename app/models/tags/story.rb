class Tags::Story < ApplicationRecord

  # inverse_of corregido (:tags_stories no existe en el join, es :tags_story);
  # ver nota en app/models/story.rb.
  has_many :tags_story_joins, class_name: 'Tags::StoryJoin', dependent: :destroy, inverse_of: :tags_story
  has_many :stories, through: :tags_story_joins

end
