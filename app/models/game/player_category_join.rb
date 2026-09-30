class Game::PlayerCategoryJoin < ApplicationRecord
  belongs_to :player, class_name: 'Game::Player', inverse_of: :player_category_joins
  belongs_to :club_category, class_name: 'Game::ClubCategory', inverse_of: :player_category_joins

  validates :player_id, uniqueness: { scope: :club_category_id }
end
