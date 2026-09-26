class Tags::StoryJoin < ApplicationRecord

  belongs_to :story, class_name: 'Story'
  belongs_to :tags_story, class_name: 'Tags::Story'

end
