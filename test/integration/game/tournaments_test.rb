require 'test_helper'

class Game::TournamentsTest < ActionDispatch::IntegrationTest
  setup do
    @tournament = Game::Tournament.create!(name: 'Torneo visible', about: 'Desc', start_date: Date.today)
  end

  test 'torneos se listan públicamente' do
    get game_tournaments_path
    assert_response :success
    assert_select 'a', text: @tournament.name
  end

  test 'detalle muestra grupos y enlace de crear grupo' do
    sign_in User.create!(email: 'liga-t@ejemplo.com', password: 'secret123', role: :league_admin)
    get game_tournament_path(@tournament)
    assert_response :success
  end

  test 'visitante no puede crear torneos' do
    sign_in User.create!(email: 'vis-t@ejemplo.com', password: 'secret123')
    assert_no_difference 'Game::Tournament.count' do
      post game_tournaments_path, params: { game_tournament: { name: 'X', about: 'Y', start_date: Date.today } }
    end
    assert_redirected_to root_path
  end

  test 'league admin puede crear torneos' do
    sign_in User.create!(email: 'liga-c@ejemplo.com', password: 'secret123', role: :league_admin)
    assert_difference 'Game::Tournament.count', 1 do
      post game_tournaments_path, params: { game_tournament: { name: 'Nuevo torneo', about: 'Desc', start_date: Date.today } }
    end
  end

  test 'league admin crea grupos del torneo' do
    sign_in User.create!(email: 'liga-g@ejemplo.com', password: 'secret123', role: :league_admin)
    assert_difference 'Game::Tournament::Group.count', 1 do
      post game_tournament_groups_path(@tournament), params: { game_tournament_group: { name: 'Grupo A' } }
    end
  end

  test 'club admin no puede crear torneos' do
    admin = User.create!(email: 'club-t@ejemplo.com', password: 'secret123', role: :club_admin)
    sign_in admin
    assert_no_difference 'Game::Tournament.count' do
      post game_tournaments_path, params: { game_tournament: { name: 'Z', about: 'Y', start_date: Date.today } }
    end
    assert_redirected_to root_path
  end
end
