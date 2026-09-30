class Game::TournamentsController < ApplicationController
  before_action :set_tournament, only: %i[show edit update destroy]

  def index
    authorize! :read, Game::Tournament
    @tournaments = Game::Tournament.order(:start_date, :name)
  end

  def show
    authorize! :read, @tournament
    @groups = @tournament.groups.order(:name)
  end

  def new
    @tournament = Game::Tournament.new
    authorize! :create, @tournament
  end

  def create
    @tournament = Game::Tournament.new(tournament_params)
    authorize! :create, @tournament

    if @tournament.save
      redirect_to game_tournament_path(@tournament), notice: 'Torneo creado.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize! :update, @tournament
  end

  def update
    authorize! :update, @tournament

    if @tournament.update(tournament_params)
      redirect_to game_tournament_path(@tournament), notice: 'Torneo actualizado.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize! :destroy, @tournament
    @tournament.destroy!
    redirect_to game_tournaments_path, notice: 'Torneo eliminado.'
  end

  private

  def set_tournament
    @tournament = Game::Tournament.friendly.find(params[:id])
  end

  def tournament_params
    params.require(:game_tournament).permit(:name, :about, :start_date, :end_date, :country, :region, :city, :organizer)
  end
end
