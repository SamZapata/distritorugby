module Tag
  class TagGroup < ActiveRecord::Base
    belongs_to :news, class_name: 'News'
    belongs_to :tag_news, class_name: 'Tag::TagNews'
  end
end
