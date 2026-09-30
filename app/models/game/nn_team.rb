class Game::NnTeam < ApplicationRecord
  validates :name, presence: true

  # Divergencia del legacy: el legacy declaraba has_many :players sin FK
  # en game_players (no existe nn_team_id); se deja como entidad simple.
end
