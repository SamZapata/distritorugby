class Game::Club::FetchInfoClub
  def call(club)
    puts "===== Fetch Club Information ====="
    result = {}
    result[:categories] = club.club_categories
    puts result
    puts "===== Fetch Club Information ====="
  end
end
