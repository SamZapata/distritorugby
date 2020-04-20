class Tags::Tournament < ApplicationRecord

  has_many :tags_tournament_joins, class_name: 'Tags::TournamentJoin', dependent: :destroy, inverse_of: :tags_tournaments
  has_many :tournaments, through: :tags_tournament_joins

end
