class Game::Tournament::Group < ApplicationRecord
  belongs_to :tournament, class_name: 'Game::Tournament', foreign_key: 'tournament_id', inverse_of: :groups

  has_many :group_matches,
           class_name: 'Game::GroupMatch',
           foreign_key: :group_id,
           dependent: :destroy,
           inverse_of: :group
  # Lote 4.4: has_many :matches through :group_matches cuando exista Game::Match.

  validates :name, presence: true
end
