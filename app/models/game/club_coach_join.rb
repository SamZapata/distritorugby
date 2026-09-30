class Game::ClubCoachJoin < ApplicationRecord
  belongs_to :club, class_name: 'Game::Club', inverse_of: :club_coach_joins
  belongs_to :coach, class_name: 'Game::Coach', inverse_of: :club_coach_joins

  validates :coach_id, uniqueness: { scope: :club_id }
end
