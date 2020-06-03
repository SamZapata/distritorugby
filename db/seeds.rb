# Seed Information for Distrito Rugby 2020

%w(
  news
  stories
  unions
  clubs
  club_categories
  club_teams
  players
).each do |seed|
  puts "===== Loading seed information for: #{seed} ====="
  require_relative "core/#{seed}"
end
