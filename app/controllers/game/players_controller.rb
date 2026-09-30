class Game::PlayersController < ApplicationController
  before_action :set_player, only: %i[show edit update destroy]

  def index
    authorize! :read, Game::Player
    @players = Game::Player.order(:last_name, :first_name)
  end

  def show
    authorize! :read, @player
    @teams = @player.club_teams.order(:name)
    @categories = @player.club_categories.order(:name)
  end

  def new
    @player = Game::Player.new
    authorize! :create, @player
  end

  def create
    @player = Game::Player.new(player_params)
    authorize! :create, @player

    if @player.save
      redirect_to game_player_path(@player), notice: 'Jugador creado.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize! :update, @player
  end

  def update
    authorize! :update, @player

    if @player.update(player_params)
      redirect_to game_player_path(@player), notice: 'Jugador actualizado.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize! :destroy, @player
    @player.destroy!
    redirect_to game_players_path, notice: 'Jugador eliminado.'
  end

  private

  def set_player
    @player = Game::Player.friendly.find(params[:id])
  end

  def player_params
    params.require(:game_player).permit(:first_name, :last_name, :position, :about, :email, :phone)
  end
end
