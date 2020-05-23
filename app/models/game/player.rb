class Game::Player < ApplicationRecord

  belongs_to :club_team, class_name: 'Game::ClubTeam'
  # belongs_to :club_team, class_name: 'Game::NnTeam'

end
