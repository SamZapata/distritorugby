class Tags::TournamentJoin < ApplicationRecord

  belongs_to :tournament, class_name: 'Tournament'
  belongs_to :tags_tournament, class_name: 'Tags::Tournament'
  
end
