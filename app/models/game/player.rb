class Game::Player < ApplicationRecord

  validates :first_name, :last_name, :about, presence: true
  extend FriendlyId
  friendly_id :first_name, use: :slugged

  has_many :player_category, class_name: 'Game::PlayerCategoryJoin', dependent: :destroy, inverse_of: :players
  has_many :club_categories, through: :player_category

  has_many :player_cteam, class_name: 'Game::PlayerCteamJoin', dependent: :destroy, inverse_of: :players
  has_many :club_teams, through: :player_cteam

  # belongs_to :club_team, class_name: 'Game::NnTeam'

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
