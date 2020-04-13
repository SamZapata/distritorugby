class Core::Story::FetchStoriesByTag
  def call(tag)
    puts "=============== Fetch stories by: #{tag} =========="
    result = ::Story.includes(:tags_stories).where("tags_stories.name" => tag)
    puts "Total stories: #{result.count}"
    return result
  end
end
