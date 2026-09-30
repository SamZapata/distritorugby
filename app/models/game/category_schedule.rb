class Game::CategorySchedule < ApplicationRecord
  belongs_to :club_category, class_name: 'Game::ClubCategory', inverse_of: :category_schedules

  validates :day, presence: true
end
