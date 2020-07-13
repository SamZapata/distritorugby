class Game::Club < ApplicationRecord

  REGIONS = {
    'europe':   'Europa',
    'oceania':  'Oceanía',
    'africa':   'África',
    'america':  'América',
    'asia':     'Asia'
  }
  validates :name, presence: true, uniqueness: true
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :club_categories, class_name: 'Game::ClubCategory', dependent: :destroy

  has_many :club_matches, class_name: 'Game::ClubMatch', dependent: :destroy, inverse_of: :game_clubs
  has_many :matches, through: :club_matches

  belongs_to :union, class_name: 'Game::Union', dependent: :destroy

  has_one_attached :picture

end
