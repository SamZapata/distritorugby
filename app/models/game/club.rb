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

  validates :name, presence: true, uniqueness: true
end
