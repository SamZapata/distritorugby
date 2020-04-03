class News < ApplicationRecord

  validates :title, :summary, :talking,  presence: true

  has_many :tag_groups, class_name: 'Tag::TagGroup', dependent: :destroy, inverse_of: :news
  has_many :tag_news, :through => :tag_groups

  # accepts_nested_attributes_for :tags, allow_destroy: true

end
