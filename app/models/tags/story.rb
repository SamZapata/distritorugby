class Tags::Story < ApplicationRecord

  has_many :tags_story_joins, class_name: 'Tags::StoryJoin', dependent: :destroy, inverse_of: :tags_stories
  has_many :stories, through: :tags_story_joins

end
