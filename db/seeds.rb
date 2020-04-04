# Seed Information for Distrito Rugby 2020

%w(
  news
  stories
).each do |seed|
  puts "===== Loading seed information for: #{seed} ====="
  require_relative "core/#{seed}"
end
