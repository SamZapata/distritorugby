require 'test_helper'

class Game::ClubCategoryTest < ActiveSupport::TestCase
  test 'requiere nombre y club' do
    category = Game::ClubCategory.new

    assert_not category.valid?
    assert_includes category.errors[:name], 'no puede estar en blanco'
    assert_includes category.errors[:club], 'debe existir'
  end

  test 'destruir la categoria elimina sus horarios' do
    union = Game::Union.create!(name: 'Union categoria')
    club = Game::Club.create!(name: 'Club categoria', union: union)
    category = Game::ClubCategory.create!(name: 'Primera', club: club)
    Game::CategorySchedule.create!(day: 'Sábado', club_category: category)

    assert_difference ['Game::ClubCategory.count', 'Game::CategorySchedule.count'], -1 do
      category.destroy!
    end
  end

  test 'destruir el club elimina sus categorias' do
    union = Game::Union.create!(name: 'Union club-cat')
    club = Game::Club.create!(name: 'Club con categorias', union: union)
    Game::ClubCategory.create!(name: 'Juvenil', club: club)

    assert_difference 'Game::ClubCategory.count', -1 do
      club.destroy!
    end
  end
end
