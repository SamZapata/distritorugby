class Game::PlayerCteamJoin < ApplicationRecord

  belongs_to :player, class_name: 'Game::Player'
  belongs_to :club_team, class_name: 'Game::ClubTeam'
  
end
