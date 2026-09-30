require 'test_helper'

class Game::CoachRefereeTest < ActiveSupport::TestCase
  test 'coach requiere nombre y apellido' do
    coach = Game::Coach.new
    assert_not coach.valid?
  end

  test 'referee genera slug y abreviatura' do
    referee = Game::Referee.create!(first_name: 'Carlos', last_name: 'Ruiz')
    assert_equal 'carlos-ruiz', referee.slug
    assert_equal 'C. Ruiz', referee.abbr_name
  end

  test 'asigna coach a club y equipo' do
    union = Game::Union.create!(name: 'U coach')
    club = Game::Club.create!(name: 'C coach', union: union)
    category = Game::ClubCategory.create!(name: 'Cat coach', club: club)
    team = Game::ClubTeam.create!(name: 'Team coach', club: club, club_category: category)
    coach = Game::Coach.create!(first_name: 'Profe', last_name: 'Rugby')

    Game::ClubCoachJoin.create!(club: club, coach: coach)
    Game::CoachTeamJoin.create!(coach: coach, club_team: team)

    assert_includes club.reload.coaches, coach
    assert_includes team.reload.coaches, coach
  end
end
