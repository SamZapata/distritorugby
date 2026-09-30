# Semillas sintéticas mínimas (Lote 5).
# Los CSV con datos reales del legacy NO se migran (PII).
# Todo lo creado aquí es ficticio y sirve para desarrollo/demo.
# Idempotente: puede correrse varias veces con db:seed.

union = Game::Union.find_or_create_by!(name: 'Unión Demo') do |u|
  u.about = 'Unión ficticia para desarrollo.'
  u.country = 'Colombia'
end

club = Game::Club.find_or_create_by!(name: 'Club Demo') do |c|
  c.about = 'Club ficticio para desarrollo.'
  c.union = union
end

category = Game::ClubCategory.find_or_create_by!(name: 'Primera Demo', club: club)

team = Game::ClubTeam.where(name: 'Equipo Demo', club: club, club_category: category).first_or_create!

player = Game::Player.where(first_name: 'Demo', last_name: 'Jugador').first_or_create!

Game::PlayerCategoryJoin.where(player: player, club_category: category).first_or_create!
Game::PlayerCteamJoin.where(player: player, club_team: team).first_or_create!

tournament = Game::Tournament.where(name: 'Torneo Demo').first_or_create! do |t|
  t.about = 'Torneo ficticio para desarrollo.'
  t.start_date = Date.today
end

Game::Tournament::Group.where(name: 'Grupo A Demo', tournament: tournament).first_or_create!

News.where(title: 'Noticia Demo').first_or_create! do |n|
  n.summary = 'Resumen ficticio.'
  n.talking = 'Contenido ficticio para desarrollo.'
end

puts "Semillas demo listas: #{Game::Club.count} clubes, #{Game::Player.count} jugadores, #{Game::Tournament.count} torneos."
