class Game::Referee < ApplicationRecord
  extend FriendlyId
  friendly_id :full_name, use: :slugged

  validates :first_name, :last_name, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def abbr_name
    "#{first_name[0]}. #{last_name}"
  end
end
