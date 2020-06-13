class Game::Union < ApplicationRecord

  validates :name, presence: true, uniqueness: true
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :clubs, class_name: 'Game::Club', dependent: :destroy

end
