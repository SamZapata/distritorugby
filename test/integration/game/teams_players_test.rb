require 'test_helper'

class Game::TeamsPlayersTest < ActionDispatch::IntegrationTest
  setup do
    @union = Game::Union.create!(name: 'U teams')
    @club = Game::Club.create!(name: 'C teams', union: @union)
    @category = Game::ClubCategory.create!(name: 'Cat teams', club: @club)
    @team = Game::ClubTeam.create!(name: 'Team visible', club: @club, club_category: @category)
    @player = Game::Player.create!(first_name: 'Público', last_name: 'Jugador')
  end

  test 'equipos se listan públicamente' do
    get game_club_category_teams_path(@club, @category)
    assert_response :success
    assert_select 'a', text: @team.name
  end

  test 'jugadores se listan públicamente' do
    get game_players_path
    assert_response :success
    assert_select 'a', text: @player.full_name
  end

  test 'visitante no puede crear equipos' do
    sign_in User.create!(email: 'vis-team@ejemplo.com', password: 'secret123')
    assert_no_difference 'Game::ClubTeam.count' do
      post game_club_category_teams_path(@club, @category),
           params: { game_club_team: { name: 'Nope' } }
    end
    assert_redirected_to root_path
  end

  test 'club admin asignado crea equipos de su club' do
    admin = User.create!(email: 'adm-team@ejemplo.com', password: 'secret123', role: :club_admin)
    Game::ClubAdminAssignment.create!(user: admin, club: @club)
    sign_in admin
    assert_difference 'Game::ClubTeam.count', 1 do
      post game_club_category_teams_path(@club, @category),
           params: { game_club_team: { name: 'Nuevo equipo' } }
    end
  end

  test 'club admin no crea equipos de otro club' do
    other = Game::Club.create!(name: 'Otro club team', union: @union)
    other_cat = Game::ClubCategory.create!(name: 'Otra cat', club: other)
    admin = User.create!(email: 'adm-team2@ejemplo.com', password: 'secret123', role: :club_admin)
    Game::ClubAdminAssignment.create!(user: admin, club: @club)
    sign_in admin
    assert_no_difference 'Game::ClubTeam.count' do
      post game_club_category_teams_path(other, other_cat),
           params: { game_club_team: { name: 'Intruso' } }
    end
    assert_redirected_to root_path
  end

  test 'club admin asignado crea jugadores' do
    admin = User.create!(email: 'adm-play@ejemplo.com', password: 'secret123', role: :club_admin)
    Game::ClubAdminAssignment.create!(user: admin, club: @club)
    sign_in admin
    assert_difference 'Game::Player.count', 1 do
      post game_players_path,
           params: { game_player: { first_name: 'Nuevo', last_name: 'Jugador' } }
    end
  end

  test 'solo super admin elimina jugadores' do
    staff = User.create!(email: 'staff-del@ejemplo.com', password: 'secret123', role: :club_admin)
    Game::ClubAdminAssignment.create!(user: staff, club: @club)
    sign_in staff
    assert_no_difference 'Game::Player.count' do
      delete game_player_path(@player)
    end
    assert_redirected_to root_path
  end
end
