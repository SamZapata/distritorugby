class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, { user: 0, club_admin: 1, league_admin: 2, super_admin: 3 }, default: :user

  has_one :profile, dependent: :destroy

  has_many :club_admin_assignments,
           class_name: 'Game::ClubAdminAssignment',
           dependent: :destroy,
           inverse_of: :user
  has_many :managed_clubs, through: :club_admin_assignments, source: :club

  after_create :ensure_profile

  private

  def ensure_profile
    create_profile! unless profile
  end
end
