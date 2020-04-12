class Core::News::FetchNewsByTag
  def call(tag)
    puts "=============== Fetch news by: #{tag} =========="
    result = News.includes(:tags_news).where("tags_news.name" => tag)
    puts "Total news: #{result.count}"
    return result
  end
end
