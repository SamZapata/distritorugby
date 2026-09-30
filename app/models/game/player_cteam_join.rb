class Game::PlayerCteamJoin < ApplicationRecord
  belongs_to :player, class_name: 'Game::Player', inverse_of: :player_cteam_joins
  belongs_to :club_team, class_name: 'Game::ClubTeam', inverse_of: :player_cteam_joins

  validates :player_id, uniqueness: { scope: :club_team_id }
end
