require 'test_helper'

class AbilityTest < ActiveSupport::TestCase
  test 'el invitado puede leer contenido publico' do
    ability = Ability.new(nil)
    assert ability.can?(:read, News)
    assert ability.can?(:read, Story)
    assert ability.can?(:read, User)
  end

  test 'el invitado no puede gestionar su perfil' do
    ability = Ability.new(nil)
    profile = Profile.new(user_id: 1)
    assert_not ability.can?(:manage, profile)
  end

  test 'el usuario autenticado gestiona su propio perfil' do
    user = User.create!(email: 'ability@ejemplo.com', password: 'secret123')
    ability = Ability.new(user)
    profile = Profile.new(user_id: user.id)
    assert ability.can?(:manage, profile)
  end

  test 'el usuario autenticado no gestiona el perfil de otro' do
    user = User.create!(email: 'otro@ejemplo.com', password: 'secret123')
    ability = Ability.new(user)
    perfil_ajeno = Profile.new(user_id: user.id + 1)
    assert_not ability.can?(:manage, perfil_ajeno)
  end

  test 'el usuario autenticado puede leer contenido publico' do
    user = User.create!(email: 'lector@ejemplo.com', password: 'secret123')
    ability = Ability.new(user)
    assert ability.can?(:read, News)
    assert ability.can?(:read, Story)
  end

  test 'super admin puede administrar todos los recursos' do
    user = User.create!(email: 'admin@ejemplo.com', password: 'secret123', role: :super_admin)
    ability = Ability.new(user)

    assert ability.can?(:manage, :all)
  end

  test 'club admin solo puede administrar clubes asignados' do
    union = Game::Union.create!(name: 'Union ability')
    assigned_club = Game::Club.create!(name: 'Club asignado', union: union)
    other_club = Game::Club.create!(name: 'Otro club', union: union)
    user = User.create!(email: 'club-ability@ejemplo.com', password: 'secret123', role: :club_admin)
    Game::ClubAdminAssignment.create!(user: user, club: assigned_club)
    ability = Ability.new(user)

    assert ability.can?(:update, assigned_club)
    assert_not ability.can?(:update, other_club)
    assert_not ability.can?(:create, Game::Club)
    assert_not ability.can?(:destroy, assigned_club)
  end

  test 'league admin gestiona torneos pero no clubes' do
    union = Game::Union.create!(name: 'Union liga')
    club = Game::Club.create!(name: 'Club liga', union: union)
    tournament = Game::Tournament.create!(name: 'Torneo liga', about: 'Desc', start_date: Date.today)
    user = User.create!(email: 'liga@ejemplo.com', password: 'secret123', role: :league_admin)
    ability = Ability.new(user)

    assert ability.can?(:read, Game::Club)
    assert ability.can?(:manage, tournament)
    assert ability.can?(:manage, Game::Tournament)
    assert_not ability.can?(:update, club)
    assert_not ability.can?(:create, Game::Club)
    assert_not ability.can?(:manage, Game::ClubAdminAssignment)
  end

  test 'club admin gestiona categorias y horarios solo de sus clubes' do
    union = Game::Union.create!(name: 'Unión alcance')
    own_club = Game::Club.create!(name: 'Club propio', union: union)
    other_club = Game::Club.create!(name: 'Club ajeno', union: union)
    own_category = Game::ClubCategory.create!(name: 'Propia', club: own_club)
    other_category = Game::ClubCategory.create!(name: 'Ajena', club: other_club)
    own_schedule = Game::CategorySchedule.create!(day: 'Lunes', club_category: own_category)
    other_schedule = Game::CategorySchedule.create!(day: 'Martes', club_category: other_category)
    user = User.create!(email: 'alcance@ejemplo.com', password: 'secret123', role: :club_admin)
    Game::ClubAdminAssignment.create!(user: user, club: own_club)
    ability = Ability.new(user)

    assert ability.can?(:manage, own_category)
    assert ability.can?(:manage, own_schedule)
    assert_not ability.can?(:manage, other_category)
    assert_not ability.can?(:manage, other_schedule)
    assert_not ability.can?(:create, Game::Union)
  end
end
