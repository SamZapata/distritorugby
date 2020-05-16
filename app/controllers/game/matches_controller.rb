class Game::MatchesController < ApplicationController
  before_action :set_game_match, only: [:show, :edit, :update, :destroy]

  # GET /game/matches
  # GET /game/matches.json
  def index
    @game_matches = Game::Match.all
  end

  # GET /game/matches/1
  # GET /game/matches/1.json
  def show
  end

  # GET /game/matches/new
  def new
    @game_match = Game::Match.new
  end

  # GET /game/matches/1/edit
  def edit
  end

  # POST /game/matches
  # POST /game/matches.json
  def create
    @game_match = Game::Match.new(game_match_params)

    respond_to do |format|
      if @game_match.save
        format.html { redirect_to @game_match, notice: 'Match was successfully created.' }
        format.json { render :show, status: :created, location: @game_match }
      else
        format.html { render :new }
        format.json { render json: @game_match.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /game/matches/1
  # PATCH/PUT /game/matches/1.json
  def update
    respond_to do |format|
      if @game_match.update(game_match_params)
        format.html { redirect_to @game_match, notice: 'Match was successfully updated.' }
        format.json { render :show, status: :ok, location: @game_match }
      else
        format.html { render :edit }
        format.json { render json: @game_match.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /game/matches/1
  # DELETE /game/matches/1.json
  def destroy
    @game_match.destroy
    respond_to do |format|
      format.html { redirect_to game_matches_url, notice: 'Match was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game_match
      @game_match = Game::Match.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_match_params
      params.require(:game_match).permit(:play_date, :play_time, :emb_location, :address)
    end
end
