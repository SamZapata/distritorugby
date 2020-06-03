require 'csv'

CSV.foreach(Rails.root.join('seed/seeds-players.csv'), headers: true) do |row|
  club = Game::Club.find_by(name: row['club'])
  category = Game::ClubCategory.find_by(name: row['category'], branch: row['branch'])
  teams = row['teams'].split(',')
  puts "=== teams: #{teams} ==="
  p = Game::Player.find_or_create_by(
    first_name:     row['first_name'],
    last_name:      row['last_name'],
    birthdate:      row['birthdate'],
    eps:            row['eps'],
    weight:         row['weight'],
    height:         row['height'],
    position:       row['position'],
    phone:          row['phone'],
    email:          row['email'],
    about:          row['about'],
  )
  puts "=== The player #{p.first_name} - #{p.last_name} was created successfully! ==="
end
