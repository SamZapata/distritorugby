class Game::Club < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :union, class_name: 'Game::Union'

  has_many :admin_assignments,
           class_name: 'Game::ClubAdminAssignment',
           foreign_key: :club_id,
           dependent: :destroy,
           inverse_of: :club
  has_many :administrators, through: :admin_assignments, source: :user

  has_many :club_categories,
           class_name: 'Game::ClubCategory',
           foreign_key: :club_id,
           dependent: :destroy,
           inverse_of: :club

  has_many :club_teams,
           class_name: 'Game::ClubTeam',
           foreign_key: :club_id,
           dependent: :destroy,
           inverse_of: :club

  has_many :club_matches,
           class_name: 'Game::ClubMatch',
           foreign_key: :club_id,
           dependent: :destroy,
           inverse_of: :club
  has_many :matches, through: :club_matches

  validates :name, presence: true, uniqueness: true
end
