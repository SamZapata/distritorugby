class Game::ClubCategory < ApplicationRecord
  belongs_to :club, class_name: 'Game::Club', inverse_of: :club_categories

  has_many :category_schedules,
           class_name: 'Game::CategorySchedule',
           foreign_key: :club_category_id,
           dependent: :destroy,
           inverse_of: :club_category

  # Lote 4.2: re-añadir has_many :club_teams y joins de jugadores
  # cuando se migren esos modelos.

  validates :name, presence: true
end
