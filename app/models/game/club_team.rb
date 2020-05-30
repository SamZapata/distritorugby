class Game::ClubTeam < ApplicationRecord

  has_many :player_cteam, class_name: 'Game::PlayerCteamJoin', dependent: :destroy, inverse_of: :club_teams
  has_many :players, through: :player_cteam

  has_many :team_coach_join, class_name: 'Game::CoachTeamJoin', dependent: :destroy, inverse_of: :club_teams
  has_many :coaches, through: :team_coach_join

  belongs_to :club, class_name: 'Game::Club', dependent: :destroy
  belongs_to :club_category, class_name: 'Game::ClubCategory', dependent: :destroy

end
