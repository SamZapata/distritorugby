class Game::ClubCategoriesController < ApplicationController
  before_action :set_game_club_category, only: [:show, :edit, :update, :destroy]

  # GET /game/club_categories
  # GET /game/club_categories.json
  def index
    @game_club_categories = Game::ClubCategory.all
  end

  # GET /game/club_categories/1
  # GET /game/club_categories/1.json
  def show
  end

  # GET /game/club_categories/new
  def new
    @game_club_category = Game::ClubCategory.new
  end

  # GET /game/club_categories/1/edit
  def edit
  end

  # POST /game/club_categories
  # POST /game/club_categories.json
  def create
    @game_club_category = Game::ClubCategory.new(game_club_category_params)

    respond_to do |format|
      if @game_club_category.save
        format.html { redirect_to @game_club_category, notice: 'Club category was successfully created.' }
        format.json { render :show, status: :created, location: @game_club_category }
      else
        format.html { render :new }
        format.json { render json: @game_club_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /game/club_categories/1
  # PATCH/PUT /game/club_categories/1.json
  def update
    respond_to do |format|
      if @game_club_category.update(game_club_category_params)
        format.html { redirect_to @game_club_category, notice: 'Club category was successfully updated.' }
        format.json { render :show, status: :ok, location: @game_club_category }
      else
        format.html { render :edit }
        format.json { render json: @game_club_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /game/club_categories/1
  # DELETE /game/club_categories/1.json
  def destroy
    @game_club_category.destroy
    respond_to do |format|
      format.html { redirect_to game_club_categories_url, notice: 'Club category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game_club_category
      @game_club_category = Game::ClubCategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_club_category_params
      params.require(:game_club_category).permit(:name, :branch)
    end
end
