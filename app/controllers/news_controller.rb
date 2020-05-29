class NewsController < ApplicationController
	before_action :set_news, only: [:show, :edit, :update, :destroy]

	layout 'news/layoutNews'

  def index
		@all_news = News.all
  end

	def tags
		@news_by_tag = Core::News::FetchNewsByTag.new.call params[:tag]
		@label = params[:tag]
	end

	def new
		@news = News.new
	end

	def show
	end

	def edit

	end

	def create
		@news = News.new(news_params)
		respond_to do |format|
			if @news.save
        format.html { redirect_to news_index_path, notice: t('news.notice.confirm_creation') }
      else
        format.html { render :new }
      end
		end
	end

	def update
    respond_to do |format|
      if @news.update(news_params)
        format.html { redirect_to @news, notice: t('news.notice.confirm_update') }
      else
        format.html { render :edit }
      end
    end
  end

	def destroy
    @news.destroy
    respond_to do |format|
      format.html { redirect_to news_index_path, notice: t('news.notice.confirm_destruction') }
      format.json { head :no_content }
    end
  end

	private

	def set_news
		@news = News.find(params[:id])
	end

	def news_params
		params.require(:news).permit(
			:title, :talking, :image, :image_license, :emb_video, :summary, :image_legend, :video_legend,
			tag_attributes: [
				:name,
			]
		)
	end
end
