class Game::ClubCategory < ApplicationRecord

  belongs_to :club, class_name: 'Game::Club'
  has_many :category_schedules, class_name: 'Game::CategorySchedule', dependent: :destroy
  has_many :club_teams, class_name: 'Game::ClubTeam', dependent: :destroy

  has_many :player_category, class_name: 'Game::PlayerCategoryJoin', dependent: :destroy, inverse_of: :club_categories
  has_many :players, through: :player_category

end
