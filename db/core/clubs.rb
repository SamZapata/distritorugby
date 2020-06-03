require 'csv'

CSV.foreach(Rails.root.join('seed/seeds-clubs.csv'), headers: true) do |row|
  c = Game::Club.new
  c.name          = row['name']
  c.about         = row['about']
  c.alias         = row['alias']
  c.phone         = row['phone']
  c.address       = row['address']
  c.emb_location  = row['emb_location']
  c.email         = row['email']
  c.webpage       = row['webpage']
  c.facebook      = row['facebook']
  c.instagram     = row['instagram']
  c.twitter       = row['twitter']
  c.youtube       = row['youtube']
  c.logo          = row['logo']
  c.picture       = row['picture']
  # find union
  union = Game::Union.find_by(abbr: row['union'].to_s)
  c.union_id      = union.id

  c.save
  puts "=== The club #{c.name} was created successfully! ==="
end
