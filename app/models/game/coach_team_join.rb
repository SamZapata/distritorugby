class Game::CoachTeamJoin < ApplicationRecord
  belongs_to :coach, class_name: 'Game::Coach', inverse_of: :coach_team_joins
  belongs_to :club_team, class_name: 'Game::ClubTeam', inverse_of: :coach_team_joins

  validates :coach_id, uniqueness: { scope: :club_team_id }
end
