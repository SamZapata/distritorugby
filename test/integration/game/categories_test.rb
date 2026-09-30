require 'test_helper'

class Game::CategoriesTest < ActionDispatch::IntegrationTest
  setup do
    @union = Game::Union.create!(name: 'Unión categorías')
    @club = Game::Club.create!(name: 'Club categorías', union: @union)
    @category = Game::ClubCategory.create!(name: 'Primera', club: @club)
  end

  test 'categorías se listan públicamente' do
    get game_club_categories_path(@club)
    assert_response :success
    assert_select 'a', text: @category.name
  end

  test 'detalle de categoría muestra horarios' do
    Game::CategorySchedule.create!(day: 'Sábado', club_category: @category)
    get game_club_category_path(@club, @category)
    assert_response :success
    assert_select 'li', text: 'Sábado'
  end

  test 'visitante no puede crear categorías' do
    sign_in User.create!(email: 'visitante-cat@ejemplo.com', password: 'secret123')

    assert_no_difference 'Game::ClubCategory.count' do
      post game_club_categories_path(@club), params: { game_club_category: { name: 'Nope' } }
    end
    assert_redirected_to root_path
  end

  test 'super admin puede crear categorías' do
    sign_in User.create!(email: 'super-cat@ejemplo.com', password: 'secret123', role: :super_admin)

    assert_difference 'Game::ClubCategory.count', 1 do
      post game_club_categories_path(@club), params: { game_club_category: { name: 'Juvenil' } }
    end
  end

  test 'club admin asignado puede crear categorías de su club' do
    admin = User.create!(email: 'admin-cat@ejemplo.com', password: 'secret123', role: :club_admin)
    Game::ClubAdminAssignment.create!(user: admin, club: @club)
    sign_in admin

    assert_difference 'Game::ClubCategory.count', 1 do
      post game_club_categories_path(@club), params: { game_club_category: { name: 'Femenino' } }
    end
  end

  test 'club admin no puede crear categorías de otro club' do
    other = Game::Club.create!(name: 'Otro club cat', union: @union)
    admin = User.create!(email: 'admin-cat-otro@ejemplo.com', password: 'secret123', role: :club_admin)
    Game::ClubAdminAssignment.create!(user: admin, club: other)
    sign_in admin

    assert_no_difference 'Game::ClubCategory.count' do
      post game_club_categories_path(@club), params: { game_club_category: { name: 'Intrusa' } }
    end
    assert_redirected_to root_path
  end
end
