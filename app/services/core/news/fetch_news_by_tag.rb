class Core::News::FetchNewsByTag
  def call(tag)
    News.includes(:tags_news).where(tags_news: { name: tag })
  end
end
