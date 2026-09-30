class Game::ClubTeam < ApplicationRecord
  belongs_to :club, class_name: 'Game::Club', inverse_of: :club_teams
  belongs_to :club_category, class_name: 'Game::ClubCategory', inverse_of: :club_teams

  has_many :player_cteam_joins,
           class_name: 'Game::PlayerCteamJoin',
           foreign_key: :club_team_id,
           dependent: :destroy,
           inverse_of: :club_team
  has_many :players, through: :player_cteam_joins

  has_many :coach_team_joins,
           class_name: 'Game::CoachTeamJoin',
           foreign_key: :club_team_id,
           dependent: :destroy,
           inverse_of: :club_team
  has_many :coaches, through: :coach_team_joins

  # Lote 4.5: has_many :coach_team_joins + :coaches

  validates :name, presence: true
end
