require 'test_helper'

class Game::ClubTest < ActiveSupport::TestCase
  test 'requiere nombre y union' do
    club = Game::Club.new

    assert_not club.valid?
    assert_includes club.errors[:name], "no puede estar en blanco"
    assert_includes club.errors[:union], 'debe existir'
  end

  test 'administra usuarios asignados como administradores' do
    union = Game::Union.create!(name: 'Union de prueba')
    club = Game::Club.create!(name: 'Club de prueba', union: union)
    admin = User.create!(email: 'club-admin@ejemplo.com', password: 'secret123', role: :club_admin)

    club.administrators << admin

    assert_includes admin.managed_clubs, club
  end
end
