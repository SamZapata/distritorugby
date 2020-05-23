class Game::Club < ApplicationRecord

  has_many :club_categories, class_name: 'Game::ClubCategory', dependent: :destroy

  has_many :club_matches, class_name: 'Game::ClubMatch', dependent: :destroy, inverse_of: :game_clubs
  has_many :matches, through: :club_matches

end
