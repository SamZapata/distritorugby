class Core::Story::FetchStoriesByTag
  def call(tag)
    Story.includes(:tags_stories).where(tags_stories: { name: tag })
  end
end
