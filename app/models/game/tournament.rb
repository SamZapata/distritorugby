class Game::Tournament < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :groups,
           class_name: 'Game::Tournament::Group',
           foreign_key: :tournament_id,
           dependent: :destroy,
           inverse_of: :tournament

  # Cadena Tournament → Group → Match → MatchStat (Fase 1A).
  has_many :group_matches,
           class_name: 'Game::GroupMatch',
           through: :groups,
           source: :group_matches
  has_many :matches, through: :group_matches

  has_many :tags_tournament_joins, class_name: 'Tags::TournamentJoin', foreign_key: :game_tournament_id, dependent: :destroy, inverse_of: :tournament
  has_many :tags_tournaments, through: :tags_tournament_joins

  validates :name, presence: true, uniqueness: true
  validates :about, :start_date, presence: true
end
