class Game::ClubCategoriesController < ApplicationController
  before_action :set_club
  before_action :set_category, only: %i[show edit update destroy]

  def index
    authorize! :read, Game::ClubCategory
    @categories = @club.club_categories.order(:name)
  end

  def show
    authorize! :read, @category
    @schedules = @category.category_schedules.order(:day)
  end

  def new
    @category = @club.club_categories.new
    authorize! :create, @category
  end

  def create
    @category = @club.club_categories.new(category_params)
    authorize! :create, @category

    if @category.save
      redirect_to game_club_category_path(@club, @category), notice: 'Categoría creada.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize! :update, @category
  end

  def update
    authorize! :update, @category

    if @category.update(category_params)
      redirect_to game_club_category_path(@club, @category), notice: 'Categoría actualizada.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize! :destroy, @category
    @category.destroy!
    redirect_to game_club_categories_path(@club), notice: 'Categoría eliminada.'
  end

  private

  def set_club
    @club = Game::Club.friendly.find(params[:club_id])
  end

  def set_category
    @category = @club.club_categories.find(params[:id])
  end

  def category_params
    params.require(:game_club_category).permit(:name, :branch)
  end
end
