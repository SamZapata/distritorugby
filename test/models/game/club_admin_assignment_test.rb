require 'test_helper'

class Game::ClubAdminAssignmentTest < ActiveSupport::TestCase
  test 'rechaza usuarios sin rol de administrador de club' do
    union = Game::Union.create!(name: 'Union invalida')
    club = Game::Club.create!(name: 'Club invalido', union: union)
    user = User.create!(email: 'usuario@ejemplo.com', password: 'secret123')

    assignment = Game::ClubAdminAssignment.new(user: user, club: club)

    assert_not assignment.valid?
    assert_includes assignment.errors[:user], 'debe tener el rol de administrador de club'
  end

  test 'no permite duplicar la asignacion de un administrador' do
    union = Game::Union.create!(name: 'Union duplicada')
    club = Game::Club.create!(name: 'Club duplicado', union: union)
    user = User.create!(email: 'duplicado@ejemplo.com', password: 'secret123', role: :club_admin)

    Game::ClubAdminAssignment.create!(user: user, club: club)
    duplicate = Game::ClubAdminAssignment.new(user: user, club: club)

    assert_not duplicate.valid?
    assert_includes duplicate.errors[:club_id], 'ya está en uso'
  end
end
