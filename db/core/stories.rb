require 'csv'

# first time just Story
CSV.foreach(Rails.root.join('seed/update_040420_stories.csv'), headers: true) do |row|
  # create tags for stories
  tags = row['tags'].split(/, */)
  tags.each do |tag|
    Tags::Story.find_or_create_by(name: tag)
  end

  # create stories
  s = Story.new
  s.name = row['name']
  s.summary = row['summary']
  s.body = row['body']
  s.image = row['image_src']
  s.image_caption = row['image_legend']
  s.emb_video = row['video_emb']
  s.video_caption = row['video_legend']
  s.tags = row['tags']
  s.save
  puts "The story of #{s.name} was created successfully!"

  # create relationships
  tags.each do |tag|
    next unless Tags::Story.find_by(name: tag)
    t = Tags::Story.find_by(name: tag)
    Tags::StoryJoin.create(story_id: s.id, tags_story_id: t.id)
    puts "<< the relationships was created >>"
  end
end
