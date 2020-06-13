class Game::Tournament < ApplicationRecord

  validates :name, presence: true, uniqueness: true
  validates :about, :start_date, presence: true
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :groups, class_name: 'Game::Tournament::Group', dependent: :destroy

  has_many :tags_tournament_joins, class_name: 'Tags::TournamentJoin', dependent: :destroy, inverse_of: :tournaments
  has_many :tags_tournaments, through: :tags_tournament_joins

end
