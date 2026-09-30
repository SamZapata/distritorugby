class NewsController < ApplicationController
  before_action :set_news, only: %i[show edit update destroy]

  def index
    authorize! :read, News
    @all_news = News.order(created_at: :desc)
  end

  def tags
    authorize! :read, News
    @label = params[:tag]
    @news_by_tag = Core::News::FetchNewsByTag.new.call(params[:tag])
  end

  def show
    authorize! :read, @news
    @label = params[:tag]
  end

  def new
    @news = News.new
    authorize! :create, @news
  end

  def create
    @news = News.new(news_params)
    authorize! :create, @news

    if @news.save
      redirect_to news_path(@news), notice: 'Noticia creada.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize! :update, @news
  end

  def update
    authorize! :update, @news

    if @news.update(news_params)
      redirect_to news_path(@news), notice: 'Noticia actualizada.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize! :destroy, @news
    @news.destroy!
    redirect_to news_index_path, notice: 'Noticia eliminada.'
  end

  private

  def set_news
    @news = News.friendly.find(params[:id])
  end

  def news_params
    params.require(:news).permit(:title, :summary, :talking)
  end
end
