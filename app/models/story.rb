class Story < ApplicationRecord

  validates :name, :summary, :body, :image, :image_caption, presence: true

  has_many :tags_story_joins, class_name: 'Tags::StoryJoin', dependent: :destroy, inverse_of: :stories
  has_many :tags_stories, through: :tags_story_joins
  
end
