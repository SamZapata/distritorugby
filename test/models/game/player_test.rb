require 'test_helper'

class Game::PlayerTest < ActiveSupport::TestCase
  test 'requiere nombre y apellido' do
    player = Game::Player.new
    assert_not player.valid?
    assert_includes player.errors[:first_name], 'no puede estar en blanco'
  end

  test 'genera slug del nombre completo' do
    player = Game::Player.create!(first_name: 'Juan', last_name: 'Pérez')
    assert_equal 'juan-perez', player.slug
  end

  test 'asigna jugador a equipo y categoria' do
    union = Game::Union.create!(name: 'U join')
    club = Game::Club.create!(name: 'C join', union: union)
    category = Game::ClubCategory.create!(name: 'Cat join', club: club)
    team = Game::ClubTeam.create!(name: 'Team join', club: club, club_category: category)
    player = Game::Player.create!(first_name: 'Ana', last_name: 'Rugby')

    Game::PlayerCteamJoin.create!(player: player, club_team: team)
    Game::PlayerCategoryJoin.create!(player: player, club_category: category)

    assert_includes team.reload.players, player
    assert_includes category.reload.players, player
  end
end
