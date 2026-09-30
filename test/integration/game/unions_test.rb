require 'test_helper'

class Game::UnionsTest < ActionDispatch::IntegrationTest
  setup do
    @union = Game::Union.create!(name: 'Unión visible')
  end

  test 'uniones se pueden consultar públicamente' do
    get game_unions_path
    assert_response :success
    assert_select 'a', text: @union.name
  end

  test 'detalle de unión lista sus clubes' do
    club = Game::Club.create!(name: 'Club de unión', union: @union)
    get game_union_path(@union)
    assert_response :success
    assert_select 'a', text: club.name
  end

  test 'solo super admin puede crear uniones' do
    sign_in User.create!(email: 'visitante-union@ejemplo.com', password: 'secret123')

    assert_no_difference 'Game::Union.count' do
      post game_unions_path, params: { game_union: { name: 'No autorizada' } }
    end
    assert_redirected_to root_path
  end

  test 'super admin puede crear uniones' do
    sign_in User.create!(email: 'super-union@ejemplo.com', password: 'secret123', role: :super_admin)

    assert_difference 'Game::Union.count', 1 do
      post game_unions_path, params: { game_union: { name: 'Nueva unión' } }
    end
  end

  test 'club admin no puede crear uniones' do
    admin = User.create!(email: 'club-union@ejemplo.com', password: 'secret123', role: :club_admin)
    sign_in admin

    assert_no_difference 'Game::Union.count' do
      post game_unions_path, params: { game_union: { name: 'Otra unión' } }
    end
    assert_redirected_to root_path
  end
end
