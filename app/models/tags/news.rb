class Tags::News < ApplicationRecord

  has_many :tags_news_joins, class_name: 'Tags::NewsJoin', dependent: :destroy, inverse_of: :tags_news
  has_many :news, through: :tags_news_joins

end
