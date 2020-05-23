class Game::PlayersController < ApplicationController
  before_action :set_game_player, only: [:show, :edit, :update, :destroy]

  # GET /game/players
  # GET /game/players.json
  def index
    @game_players = Game::Player.all
  end

  # GET /game/players/1
  # GET /game/players/1.json
  def show
  end

  # GET /game/players/new
  def new
    @game_player = Game::Player.new
  end

  # GET /game/players/1/edit
  def edit
  end

  # POST /game/players
  # POST /game/players.json
  def create
    @game_player = Game::Player.new(game_player_params)

    respond_to do |format|
      if @game_player.save
        format.html { redirect_to @game_player, notice: 'Player was successfully created.' }
        format.json { render :show, status: :created, location: @game_player }
      else
        format.html { render :new }
        format.json { render json: @game_player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /game/players/1
  # PATCH/PUT /game/players/1.json
  def update
    respond_to do |format|
      if @game_player.update(game_player_params)
        format.html { redirect_to @game_player, notice: 'Player was successfully updated.' }
        format.json { render :show, status: :ok, location: @game_player }
      else
        format.html { render :edit }
        format.json { render json: @game_player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /game/players/1
  # DELETE /game/players/1.json
  def destroy
    @game_player.destroy
    respond_to do |format|
      format.html { redirect_to game_players_url, notice: 'Player was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game_player
      @game_player = Game::Player.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_player_params
      params.require(:game_player).permit(:first_name, :last_name, :identification, :birthdate, :eps, :weigth, :height, :position, :phone, :injuries, :about, :email)
    end
end
