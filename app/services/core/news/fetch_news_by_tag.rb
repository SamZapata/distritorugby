class Core::News::FetchNewsByTag
  def call(tag)
    result = News.includes(:tags_news).where("tags_news.name" => tag)
    puts '===============Come here my friend=========='
    puts result
    puts '===============Come here my friend=========='
    return result
  end
end
