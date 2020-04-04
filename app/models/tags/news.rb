class Tags::News < ApplicationRecord

  has_many :tags_news_joins, class_name: 'Tags::NewsJoin', dependent: :destroy, inverse_of: :tag_news
  has_many :news, through: :tags_news_joins

end
