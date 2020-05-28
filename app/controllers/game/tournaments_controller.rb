class Game::TournamentsController < ApplicationController
  before_action :set_game_tournament, only: [:show, :edit, :update, :destroy]

  layout 'tournaments/layoutTournament'

  # GET /game/tournaments
  # GET /game/tournaments.json
  def index
    @all_tournaments = Game::Tournament.all
  end

  # GET /game/tournaments/1
  # GET /game/tournaments/1.json
  def show
  end

  # GET /game/tournaments/new
  def new
    @game_tournament = Game::Tournament.new
  end

  # GET /game/tournaments/1/edit
  def edit
  end

  # POST /game/tournaments
  # POST /game/tournaments.json
  def create
    @game_tournament = Game::Tournament.new(game_tournament_params)

    respond_to do |format|
      if @game_tournament.save
        format.html { redirect_to @game_tournament, notice: 'Tournament was successfully created.' }
        format.json { render :show, status: :created, location: @game_tournament }
      else
        format.html { render :new }
        format.json { render json: @game_tournament.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /game/tournaments/1
  # PATCH/PUT /game/tournaments/1.json
  def update
    respond_to do |format|
      if @game_tournament.update(game_tournament_params)
        format.html { redirect_to @game_tournament, notice: 'Tournament was successfully updated.' }
        format.json { render :show, status: :ok, location: @game_tournament }
      else
        format.html { render :edit }
        format.json { render json: @game_tournament.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /game/tournaments/1
  # DELETE /game/tournaments/1.json
  def destroy
    @game_tournament.destroy
    respond_to do |format|
      format.html { redirect_to game_tournaments_url, notice: 'Tournament was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game_tournament
      @game_tournament = Game::Tournament.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_tournament_params
      params.require(:game_tournament).permit(:name, :start_date, :end_date, :about, :country, :region, :city, :organizer)
    end
end
