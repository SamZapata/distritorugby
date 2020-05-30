class Game::PlayerCategoryJoin < ApplicationRecord

  belongs_to :player, class_name: 'Game::Player'
  belongs_to :club_category, class_name: 'Game::ClubCategory'

end
