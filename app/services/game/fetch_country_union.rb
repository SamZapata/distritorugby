class Game::FetchCountryUnion
  def call
    puts "=====Countries by Union/Federation"
    unions = Game::Union.all
    result = unions.map do |u|
      u.country
    end
    return result
  end
end
