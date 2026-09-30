class Tags::TournamentJoin < ApplicationRecord
  belongs_to :tournament, class_name: 'Game::Tournament', foreign_key: :game_tournament_id, inverse_of: :tags_tournament_joins
  belongs_to :tags_tournament, class_name: 'Tags::Tournament', inverse_of: :tags_tournament_joins
end
