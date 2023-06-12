require 'csv'

CSV.foreach(Rails.root.join('seed/seeds-news.csv'), headers: true) do |row|
  # create tags for news
  tags = row['tags'].split(/, */)
  tags.each do |tag|
    Tags::News.find_or_create_by(name: tag)
  end

  # create news
  n = News.new
  n.title = Faker::Lorem.sentence
  n.summary = row['summary']
  n.talking = row['body']
  debugger
  n.image = row['image_src']
  n.image_legend = row['image_legend']
  # n.emb_video = row['video_emb']
  # n.video_legend = row['video_legend']
  n.tags = row['tags']
  n.save
  puts "The news #{n.title} was created successfully!"

  # create relationships
  tags.each do |tag|
    next unless Tags::News.find_by(name: tag)
    t = Tags::News.find_by(name: tag)
    Tags::NewsJoin.create(news_id: n.id, tags_news_id: t.id)
    puts "<< the relationships was created >>"
  end
end
