class News < ApplicationRecord

  validates :title, presence: true, uniqueness: true
  validates :summary, :talking,  presence: true
  extend FriendlyId
  friendly_id :title, use: :slugged


  has_many :tags_news_joins, class_name: 'Tags::NewsJoin', dependent: :destroy, inverse_of: :news
  has_many :tags_news, through: :tags_news_joins

  # accepts_nested_attributes_for :tags, allow_destroy: true

end
