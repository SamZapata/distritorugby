class Game::ClubCoachJoin < ApplicationRecord

  belongs_to :club, class_name: "Game::Club", dependent: :destroy
  belongs_to :coach, class_name: "Game::Coach", dependent: :destroy

end
