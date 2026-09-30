require 'test_helper'

class Game::TournamentTest < ActiveSupport::TestCase
  test 'requiere nombre, descripcion y fecha de inicio' do
    tournament = Game::Tournament.new
    assert_not tournament.valid?
    assert_includes tournament.errors[:name], 'no puede estar en blanco'
  end

  test 'destruir torneo elimina sus grupos' do
    tournament = Game::Tournament.create!(name: 'Torneo test', about: 'Desc', start_date: Date.today)
    Game::Tournament::Group.create!(name: 'Grupo A', tournament: tournament)

    assert_difference 'Game::Tournament::Group.count', -1 do
      tournament.destroy!
    end
  end
end
