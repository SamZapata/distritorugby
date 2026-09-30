class HomeController < ApplicationController
  def index
    result = Core::Base::FiltersByModel.new.call
    @filters_by_model = result[:objects]
    @latest_news = News.order(created_at: :desc).limit(3)
    @latest_tournaments = Game::Tournament.order(start_date: :desc).limit(3)
  end

  def about
  end
end
