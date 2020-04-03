module Tag
  class TagNews < ActiveRecord::Base
    has_many :tag_groups, class_name: 'Tag::TagGroup', dependent: :destroy, inverse_of: :tag_news
    has_many :news, :through => :tag_groups
  end
end
