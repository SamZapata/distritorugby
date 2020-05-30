class Game::Union < ApplicationRecord

  has_many :clubs, class_name: 'Game::Club', dependent: :destroy

end
