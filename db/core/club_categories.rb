require 'csv'

CSV.foreach(Rails.root.join('seed/seeds-club_categories.csv'), headers: true) do |row|
  club = Game::Club.find_by(name: row['club'])
  cc = Game::ClubCategory.find_or_create_by(
    name:     row['name'],
    branch:   row['branch'],
    club_id:  club.id
  )
  puts "=== The club category #{cc.name} - #{cc.branch} was created successfully! ==="
end
