class News < ApplicationRecord

  has_many :tags, class_name: 'Tag'

  accepts_nested_attributes_for :tags, allow_destroy: true

end
