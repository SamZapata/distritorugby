require 'test_helper'

class Game::MatchTest < ActiveSupport::TestCase
  test 'requiere fecha' do
    match = Game::Match.new
    assert_not match.valid?
    assert_includes match.errors[:play_date], 'no puede estar en blanco'
  end

  test 'calcula el marcador desde la estadística' do
    match = Game::Match.create!(play_date: Date.today)
    Game::MatchStat.create!(match: match, tries_a: 2, conversions_a: 1, tries_b: 1)
    assert_equal 12, match.match_stat.total_score_a
    assert_equal 5, match.match_stat.total_score_b
  end

  test 'cadena torneo-grupo-partido-stat' do
    tournament = Game::Tournament.create!(name: 'T cadena', about: 'D', start_date: Date.today)
    group = Game::Tournament::Group.create!(name: 'G cadena', tournament: tournament)
    match = Game::Match.create!(play_date: Date.today)
    Game::GroupMatch.create!(group: group, match: match)
    assert_includes tournament.reload.matches, match
    assert_includes group.reload.matches, match
  end
end
