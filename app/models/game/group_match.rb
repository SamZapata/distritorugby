class Game::GroupMatch < ApplicationRecord
  belongs_to :group, class_name: 'Game::Tournament::Group', inverse_of: :group_matches
  belongs_to :match, class_name: 'Game::Match', inverse_of: :group_matches

  validates :group_id, uniqueness: { scope: :match_id }
end
