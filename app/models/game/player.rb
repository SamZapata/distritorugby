class Game::Player < ApplicationRecord

  has_many :player_category, class_name: 'Game::PlayerCategoryJoin', dependent: :destroy, inverse_of: :players
  has_many :club_categories, through: :player_category

  has_many :player_cteam, class_name: 'Game::PlayerCteamJoin', dependent: :destroy, inverse_of: :players
  has_many :club_teams, through: :player_cteam

  # belongs_to :club_team, class_name: 'Game::NnTeam'

end
