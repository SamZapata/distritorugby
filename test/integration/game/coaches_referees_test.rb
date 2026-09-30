require 'test_helper'

class Game::CoachesRefereesTest < ActionDispatch::IntegrationTest
  test 'entrenadores y árbitros se listan públicamente' do
    Game::Coach.create!(first_name: 'Público', last_name: 'Coach')
    Game::Referee.create!(first_name: 'Público', last_name: 'Ref')
    get game_coaches_path
    assert_response :success
    get game_referees_path
    assert_response :success
  end

  test 'visitante no crea entrenadores' do
    sign_in User.create!(email: 'vis-c@ejemplo.com', password: 'secret123')
    assert_no_difference 'Game::Coach.count' do
      post game_coaches_path, params: { game_coach: { first_name: 'X', last_name: 'Y' } }
    end
    assert_redirected_to root_path
  end

  test 'league admin crea entrenadores y árbitros' do
    sign_in User.create!(email: 'liga-c@ejemplo.com', password: 'secret123', role: :league_admin)
    assert_difference 'Game::Coach.count', 1 do
      post game_coaches_path, params: { game_coach: { first_name: 'Nuevo', last_name: 'Coach' } }
    end
    assert_difference 'Game::Referee.count', 1 do
      post game_referees_path, params: { game_referee: { first_name: 'Nuevo', last_name: 'Ref' } }
    end
  end

  test 'club admin no crea entrenadores' do
    sign_in User.create!(email: 'club-c@ejemplo.com', password: 'secret123', role: :club_admin)
    assert_no_difference 'Game::Coach.count' do
      post game_coaches_path, params: { game_coach: { first_name: 'Z', last_name: 'W' } }
    end
    assert_redirected_to root_path
  end
end
