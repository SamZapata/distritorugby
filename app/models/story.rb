class Story < ApplicationRecord

  validates :name, presence: true, uniqueness: true
  validates :summary, :body, :image, :image_caption, presence: true
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :tags_story_joins, class_name: 'Tags::StoryJoin', dependent: :destroy, inverse_of: :stories
  has_many :tags_stories, through: :tags_story_joins

end
