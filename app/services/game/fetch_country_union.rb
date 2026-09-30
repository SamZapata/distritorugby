class Game::FetchCountryUnion
  def call
    Game::Union.all.map(&:country).compact.uniq
  end
end
