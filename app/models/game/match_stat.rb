class Game::MatchStat < ApplicationRecord
  belongs_to :match, class_name: 'Game::Match', inverse_of: :match_stat

  validates :match_id, presence: true, uniqueness: true

  def total_score_a
    (tries_a || 0) * 5 + (conversions_a || 0) * 2 +
      (penalty_goal_a || 0) * 3 + (drop_goal_a || 0) * 3
  end

  def total_score_b
    (tries_b || 0) * 5 + (conversions_b || 0) * 2 +
      (penalty_goal_b || 0) * 3 + (drop_goal_b || 0) * 3
  end
end
