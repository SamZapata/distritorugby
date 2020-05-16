class Game::Tournament < ApplicationRecord

  validates :name, :about, :start_date, presence: true

  has_many :groups, class_name: 'Game::Tournament::Group', dependent: :destroy

  has_many :tags_tournament_joins, class_name: 'Tags::TournamentJoin', dependent: :destroy, inverse_of: :tournaments
  has_many :tags_tournaments, through: :tags_tournament_joins

end
