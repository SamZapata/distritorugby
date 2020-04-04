class Tags::NewsJoin < ApplicationRecord

  belongs_to :news, class_name: 'News'
  belongs_to :tags_news, class_name: 'Tags::News'
  
end
