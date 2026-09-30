class Game::Player < ApplicationRecord
  extend FriendlyId
  friendly_id :full_name, use: :slugged

  has_many :player_category_joins,
           class_name: 'Game::PlayerCategoryJoin',
           foreign_key: :player_id,
           dependent: :destroy,
           inverse_of: :player
  has_many :club_categories, through: :player_category_joins

  has_many :player_cteam_joins,
           class_name: 'Game::PlayerCteamJoin',
           foreign_key: :player_id,
           dependent: :destroy,
           inverse_of: :player
  has_many :club_teams, through: :player_cteam_joins

  validates :first_name, :last_name, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def abbr_name
    "#{first_name[0]}. #{last_name}"
  end
end
