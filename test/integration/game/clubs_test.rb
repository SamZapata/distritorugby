require 'test_helper'

class Game::ClubsTest < ActionDispatch::IntegrationTest
  setup do
    @union = Game::Union.create!(name: 'Union clubes test')
    @club = Game::Club.create!(name: 'Club visible test', union: @union)
  end

  test 'clubes se pueden consultar publicamente' do
    get game_clubs_path

    assert_response :success
    assert_select 'a', text: @club.name
  end

  test 'el detalle de club se renderiza publicamente' do
    get game_club_path(@club)

    assert_response :success
    assert_select '.club-title', text: @club.name.titleize
  end

  test 'super admin puede abrir el formulario de creacion' do
    sign_in User.create!(email: 'super-admin-new@ejemplo.com', password: 'secret123', role: :super_admin)

    get new_game_club_path

    assert_response :success
    assert_select 'select[name="game_club[union_id]"]'
  end

  test 'solo super admin puede crear clubes' do
    sign_in User.create!(email: 'visitante-clubs@ejemplo.com', password: 'secret123')

    assert_no_difference 'Game::Club.count' do
      post game_clubs_path, params: {
        game_club: { name: 'Club no autorizado', union_id: @union.id }
      }
    end

    assert_redirected_to root_path
  end

  test 'club admin asignado puede actualizar los datos de su club' do
    admin = User.create!(email: 'admin-asignado@ejemplo.com', password: 'secret123', role: :club_admin)
    Game::ClubAdminAssignment.create!(user: admin, club: @club)
    sign_in admin

    patch game_club_path(@club), params: {
      game_club: { name: 'Club actualizado', union_id: @union.id }
    }

    assert_redirected_to game_club_path(@club)
    assert_equal 'Club actualizado', @club.reload.name
  end

  test 'club admin asignado puede abrir el formulario de edicion' do
    admin = User.create!(email: 'admin-edita@ejemplo.com', password: 'secret123', role: :club_admin)
    Game::ClubAdminAssignment.create!(user: admin, club: @club)
    sign_in admin

    get edit_game_club_path(@club)

    assert_response :success
    assert_select 'form'
  end

  test 'club admin no puede editar un club no asignado' do
    admin = User.create!(email: 'admin-otro-club@ejemplo.com', password: 'secret123', role: :club_admin)
    sign_in admin

    get edit_game_club_path(@club)

    assert_redirected_to root_path
  end

  test 'club admin asignado no puede reasignar el club a otra union' do
    other_union = Game::Union.create!(name: 'Otra union')
    admin = User.create!(email: 'admin-union@ejemplo.com', password: 'secret123', role: :club_admin)
    Game::ClubAdminAssignment.create!(user: admin, club: @club)
    sign_in admin

    patch game_club_path(@club), params: {
      game_club: { name: @club.name, union_id: other_union.id }
    }

    assert_equal @union.id, @club.reload.union_id
  end

  test 'super admin puede asignar un administrador de club' do
    super_admin = User.create!(email: 'super-admin-asignacion@ejemplo.com', password: 'secret123', role: :super_admin)
    admin = User.create!(email: 'admin-asignacion@ejemplo.com', password: 'secret123', role: :club_admin)
    sign_in super_admin

    assert_difference 'Game::ClubAdminAssignment.count', 1 do
      post game_club_admin_assignments_path(@club), params: { user_id: admin.id }
    end

    assert_redirected_to game_club_path(@club)
    assert_includes @club.reload.administrators, admin
  end

  test 'detalle de club permite al super admin administrar las asignaciones' do
    super_admin = User.create!(email: 'super-admin-detalle@ejemplo.com', password: 'secret123', role: :super_admin)
    admin = User.create!(email: 'admin-detalle@ejemplo.com', password: 'secret123', role: :club_admin)
    Game::ClubAdminAssignment.create!(user: admin, club: @club)
    sign_in super_admin

    get game_club_path(@club)

    assert_response :success
    assert_select 'form[action=?]', game_club_admin_assignments_path(@club)
    assert_select 'li', text: /#{Regexp.escape(admin.email)}/
  end

  test 'club admin no puede asignar otro administrador' do
    current_admin = User.create!(email: 'admin-no-asigna@ejemplo.com', password: 'secret123', role: :club_admin)
    other_admin = User.create!(email: 'admin-no-asigna-2@ejemplo.com', password: 'secret123', role: :club_admin)
    Game::ClubAdminAssignment.create!(user: current_admin, club: @club)
    sign_in current_admin

    assert_no_difference 'Game::ClubAdminAssignment.count' do
      post game_club_admin_assignments_path(@club), params: { user_id: other_admin.id }
    end

    assert_redirected_to root_path
  end
end
