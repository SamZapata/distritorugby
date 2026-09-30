class StoriesController < ApplicationController
  before_action :set_story, only: %i[show edit update destroy]

  def index
    authorize! :read, Story
    @all_stories = Story.order(created_at: :desc)
  end

  def tags
    authorize! :read, Story
    @label = params[:tag]
    @stories_by_tag = Core::Story::FetchStoriesByTag.new.call(params[:tag])
  end

  def show
    authorize! :read, @story
    @label = params[:tag]
  end

  def new
    @story = Story.new
    authorize! :create, @story
  end

  def create
    @story = Story.new(story_params)
    authorize! :create, @story

    if @story.save
      redirect_to story_path(@story), notice: 'Historia creada.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize! :update, @story
  end

  def update
    authorize! :update, @story

    if @story.update(story_params)
      redirect_to story_path(@story), notice: 'Historia actualizada.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize! :destroy, @story
    @story.destroy!
    redirect_to stories_path, notice: 'Historia eliminada.'
  end

  private

  def set_story
    @story = Story.friendly.find(params[:id])
  end

  def story_params
    params.require(:story).permit(:name, :summary, :body, :image_caption, :image)
  end
end
