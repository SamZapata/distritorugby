require 'csv'

CSV.foreach(Rails.root.join('seed/seeds-club_teams.csv'), headers: true) do |row|
  club = Game::Club.find_by(name: row['club'])
  category = Game::ClubCategory.find_by(name: row['category'], branch: row['branch'])
  ct = Game::ClubTeam.create(
    name:             row['name'],
    about:            row['about'],
    mode:             row['mode'],
    club_id:          club.id,
    club_category_id: category.id
  )
  puts "=== The club team #{ct.name} - #{ct.mode}'s' was created successfully! ==="
end
