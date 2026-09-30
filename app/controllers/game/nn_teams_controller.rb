class Game::NnTeamsController < ApplicationController
  before_action :set_team, only: %i[show edit update destroy]

  def index
    authorize! :read, Game::NnTeam
    @teams = Game::NnTeam.order(:name)
  end

  def show
    authorize! :read, @team
  end

  def new
    @team = Game::NnTeam.new
    authorize! :create, @team
  end

  def create
    @team = Game::NnTeam.new(team_params)
    authorize! :create, @team

    if @team.save
      redirect_to game_nn_team_path(@team), notice: 'Equipo creado.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize! :update, @team
  end

  def update
    authorize! :update, @team

    if @team.update(team_params)
      redirect_to game_nn_team_path(@team), notice: 'Equipo actualizado.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize! :destroy, @team
    @team.destroy!
    redirect_to game_nn_teams_path, notice: 'Equipo eliminado.'
  end

  private

  def set_team
    @team = Game::NnTeam.find(params[:id])
  end

  def team_params
    params.require(:game_nn_team).permit(:name, :about)
  end
end
