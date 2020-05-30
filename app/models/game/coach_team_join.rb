class Game::CoachTeamJoin < ApplicationRecord

  belongs_to :coach, class_name: 'Game::Coach'
  belongs_to :club_team, class_name: 'Game::ClubTeam'
  
end
