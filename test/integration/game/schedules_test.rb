require 'test_helper'

class Game::SchedulesTest < ActionDispatch::IntegrationTest
  setup do
    @union = Game::Union.create!(name: 'Unión horarios')
    @club = Game::Club.create!(name: 'Club horarios', union: @union)
    @category = Game::ClubCategory.create!(name: 'Primera horarios', club: @club)
    @schedule = Game::CategorySchedule.create!(day: 'Sábado', club_category: @category)
  end

  test 'detalle de horario es público' do
    get game_club_category_schedule_path(@club, @category, @schedule)
    assert_response :success
    assert_select 'h1', text: 'Sábado'
  end

  test 'visitante no puede crear horarios' do
    sign_in User.create!(email: 'visitante-hor@ejemplo.com', password: 'secret123')

    assert_no_difference 'Game::CategorySchedule.count' do
      post game_club_category_schedules_path(@club, @category),
           params: { game_category_schedule: { day: 'Domingo' } }
    end
    assert_redirected_to root_path
  end

  test 'club admin asignado puede crear horarios de su club' do
    admin = User.create!(email: 'admin-hor@ejemplo.com', password: 'secret123', role: :club_admin)
    Game::ClubAdminAssignment.create!(user: admin, club: @club)
    sign_in admin

    assert_difference 'Game::CategorySchedule.count', 1 do
      post game_club_category_schedules_path(@club, @category),
           params: { game_category_schedule: { day: 'Miércoles' } }
    end
  end

  test 'club admin no puede crear horarios de otro club' do
    other = Game::Club.create!(name: 'Otro club hor', union: @union)
    other_category = Game::ClubCategory.create!(name: 'Otra cat', club: other)
    admin = User.create!(email: 'admin-hor-otro@ejemplo.com', password: 'secret123', role: :club_admin)
    Game::ClubAdminAssignment.create!(user: admin, club: @club)
    sign_in admin

    assert_no_difference 'Game::CategorySchedule.count' do
      post game_club_category_schedules_path(other, other_category),
           params: { game_category_schedule: { day: 'Intruso' } }
    end
    assert_redirected_to root_path
  end
end
