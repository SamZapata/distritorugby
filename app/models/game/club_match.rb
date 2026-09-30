class Game::ClubMatch < ApplicationRecord
  belongs_to :club, class_name: 'Game::Club', inverse_of: :club_matches
  belongs_to :match, class_name: 'Game::Match', inverse_of: :club_matches

  validates :club_id, uniqueness: { scope: :match_id }
end
