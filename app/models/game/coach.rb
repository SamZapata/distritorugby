class Game::Coach < ApplicationRecord
  extend FriendlyId
  friendly_id :full_name, use: :slugged

  has_many :club_coach_joins,
           class_name: 'Game::ClubCoachJoin',
           foreign_key: :coach_id,
           dependent: :destroy,
           inverse_of: :coach
  has_many :clubs, through: :club_coach_joins

  has_many :coach_team_joins,
           class_name: 'Game::CoachTeamJoin',
           foreign_key: :coach_id,
           dependent: :destroy,
           inverse_of: :coach
  has_many :club_teams, through: :coach_team_joins

  validates :first_name, :last_name, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def abbr_name
    "#{first_name[0]}. #{last_name}"
  end
end
