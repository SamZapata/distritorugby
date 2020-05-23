class Game::NnTeam < ApplicationRecord

  has_many :players, class_name: 'Game::Player'

  # has_many :team_coach_join, class_name: 'Game::CoachTeamJoin', dependent: :destroy, inverse_of: :game_club_teams
  # has_many :coaches, through: :team_coach_join

end
