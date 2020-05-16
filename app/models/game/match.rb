class Game::Match < ApplicationRecord

  has_many :club_matches, class_name: 'Game::ClubMatch', dependent: :destroy, inverse_of: :matches
  has_many :clubs, through: :club_matches

  has_one :match_stat, class_name: 'Game::MatchStat'

end
