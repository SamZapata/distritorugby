require 'csv'

CSV.foreach(Rails.root.join('seed/seeds-unions.csv'), headers: true) do |row|
  u = Game::Union.new
  u.name    = row['name']
  u.about   = row['about']
  u.founded = row['founded']
  u.website = row['website']
  u.logo    = row['logo']
  u.country = row['country']
  u.abbr    = row['abbr']
  u.alias   = row['alias']
  u.save
  puts "===The union/federation #{u.name} was created successfully!=="
end
