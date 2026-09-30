class Game::ClubAdminAssignment < ApplicationRecord
  belongs_to :user
  belongs_to :club, class_name: 'Game::Club'

  validates :club_id, uniqueness: { scope: :user_id }
  validate :user_must_be_club_admin

  private

  def user_must_be_club_admin
    return if user&.club_admin?

    errors.add(:user, 'debe tener el rol de administrador de club')
  end
end
