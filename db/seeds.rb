# Seed Information for Distrito Rugby 2020

require 'csv'

# first time just News
CSV.foreach(Rails.root.join('seed/update_020420_news.csv'), headers: true) do |row|
  n = News.new
  n.title = row['title']
  n.summary = row['summary']
  n.talking = row['body']
  n.image = row['image_src']
  n.image_legend = row['image_legend']
  n.emb_video = row['video_emb']
  n.video_legend = row['video_legend']
  n.tags = row['tags']
  n.save
  puts "The news #{n.title} was created successfully!"
end

# %w(
#   news
# ).each do |seed|
#   puts "Loading seed information for: #{seed}"
# end
