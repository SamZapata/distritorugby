class Game::Club::FetchInfoClub
  def call(club)
    {
      categories: club.club_categories,
      teams: club.club_teams,
      coaches: club.coaches
    }
  end
end
