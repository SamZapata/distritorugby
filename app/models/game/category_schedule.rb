class Game::CategorySchedule < ApplicationRecord

  belongs_to :club_category, class_name: 'Game::ClubCategory'

end
