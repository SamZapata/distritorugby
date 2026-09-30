class Game::Union < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :clubs, class_name: 'Game::Club', dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: true
end
