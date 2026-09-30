require 'test_helper'

class Game::MatchesTest < ActionDispatch::IntegrationTest
  setup do
    @match = Game::Match.create!(play_date: Date.today)
  end

  test 'partidos se listan públicamente' do
    get game_matches_path
    assert_response :success
  end

  test 'detalle muestra marcador cuando hay stat' do
    Game::MatchStat.create!(match: @match, tries_a: 1)
    get game_match_path(@match)
    assert_response :success
  end

  test 'visitante no crea partidos' do
    sign_in User.create!(email: 'vis-m@ejemplo.com', password: 'secret123')
    assert_no_difference 'Game::Match.count' do
      post game_matches_path, params: { game_match: { play_date: Date.today } }
    end
    assert_redirected_to root_path
  end

  test 'league admin crea partidos y carga stats' do
    sign_in User.create!(email: 'liga-m@ejemplo.com', password: 'secret123', role: :league_admin)
    assert_difference 'Game::Match.count', 1 do
      post game_matches_path, params: { game_match: { play_date: Date.today } }
    end
    match = Game::Match.last
    post game_match_stat_path(match), params: { game_match_stat: { tries_a: 3, tries_b: 1 } }
    assert_equal 15, match.reload.match_stat.total_score_a
  end

  test 'club admin no crea partidos' do
    admin = User.create!(email: 'club-m@ejemplo.com', password: 'secret123', role: :club_admin)
    sign_in admin
    assert_no_difference 'Game::Match.count' do
      post game_matches_path, params: { game_match: { play_date: Date.today } }
    end
    assert_redirected_to root_path
  end
end
