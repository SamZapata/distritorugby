class News < ApplicationRecord

  validates :title, :summary, :talking, presence: true

  # has_many :tags, class_name: 'Tag'

  # accepts_nested_attributes_for :tags, allow_destroy: true

end
