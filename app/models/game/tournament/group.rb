class Game::Tournament::Group < ApplicationRecord
  belongs_to :game_tournament, class_name: 'Game::Tournament'
end
