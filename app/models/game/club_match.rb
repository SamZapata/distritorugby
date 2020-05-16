class Game::ClubMatch < ApplicationRecord

  belongs_to :club, class_name: 'Game::Club'
  belongs_to :match, class_name: 'Game::Match'

end
