class Game::UnionsController < ApplicationController
  before_action :set_game_union, only: [:show, :edit, :update, :destroy]

  # GET /game/unions
  # GET /game/unions.json
  def index
    @game_unions = Game::Union.all
  end

  # GET /game/unions/1
  # GET /game/unions/1.json
  def show
  end

  # GET /game/unions/new
  def new
    @game_union = Game::Union.new
  end

  # GET /game/unions/1/edit
  def edit
  end

  # POST /game/unions
  # POST /game/unions.json
  def create
    @game_union = Game::Union.new(game_union_params)

    respond_to do |format|
      if @game_union.save
        format.html { redirect_to @game_union, notice: 'Union was successfully created.' }
        format.json { render :show, status: :created, location: @game_union }
      else
        format.html { render :new }
        format.json { render json: @game_union.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /game/unions/1
  # PATCH/PUT /game/unions/1.json
  def update
    respond_to do |format|
      if @game_union.update(game_union_params)
        format.html { redirect_to @game_union, notice: 'Union was successfully updated.' }
        format.json { render :show, status: :ok, location: @game_union }
      else
        format.html { render :edit }
        format.json { render json: @game_union.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /game/unions/1
  # DELETE /game/unions/1.json
  def destroy
    @game_union.destroy
    respond_to do |format|
      format.html { redirect_to game_unions_url, notice: 'Union was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game_union
      @game_union = Game::Union.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_union_params
      params.require(:game_union).permit(:name, :about, :founded, :website, :logo, :country, :abbr, :alias)
    end
end
