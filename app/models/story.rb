class Story < ApplicationRecord

  validates :name, presence: true, uniqueness: true
  validates :summary, :body, :image, :image_caption, presence: true
  extend FriendlyId
  friendly_id :name, use: :slugged

  # inverse_of corregido (:stories no existe en el join, es :story): con el
  # valor del legacy, destruir un Story con joins lanzaba
  # ActiveRecord::InverseOfAssociationNotFoundError.
  has_many :tags_story_joins, class_name: 'Tags::StoryJoin', dependent: :destroy, inverse_of: :story
  has_many :tags_stories, through: :tags_story_joins

  has_one_attached :image

end
