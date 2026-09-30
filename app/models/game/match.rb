class Game::Match < ApplicationRecord
  has_many :club_matches,
           class_name: 'Game::ClubMatch',
           foreign_key: :match_id,
           dependent: :destroy,
           inverse_of: :match
  has_many :clubs, through: :club_matches

  has_many :group_matches,
           class_name: 'Game::GroupMatch',
           foreign_key: :match_id,
           dependent: :destroy,
           inverse_of: :match
  has_many :groups, through: :group_matches

  has_one :match_stat,
          class_name: 'Game::MatchStat',
          foreign_key: :match_id,
          dependent: :destroy,
          inverse_of: :match

  belongs_to :referee, class_name: 'Game::Referee', optional: true

  validates :play_date, presence: true
end
