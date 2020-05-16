class Game::ClubCategory < ApplicationRecord

  belongs_to :club, class_name: 'Game::Club'
  has_many :category_schedules, class_name: 'Game::CategorySchedule', dependent: :destroy

end
