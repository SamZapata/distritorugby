class Game::Coach < ApplicationRecord

  validates :first_name, :last_name, :about, presence: true
  extend FriendlyId
  friendly_id :first_name, use: :slugged

  # clubs
  has_many :club_coaches, class_name: 'Game::ClubCoachJoin', dependent: :destroy, inverse_of: :coaches
  has_many :clubs, through: :club_coaches

  has_many :team_coach_join, class_name: 'Game::CoachTeamJoin', dependent: :destroy, inverse_of: :coaches
  has_many :club_teams, through: :team_coach_join

  def full_name
    first_name.titleize + " " + last_name.titleize
  end

  def abbr_name
    ln = last_name.split.first.capitalize
    fn = ""
    first_name.split.each do |n|
      fn = fn + n[0].capitalize + ". "
    end
    return ln + " " + fn
  end

end
