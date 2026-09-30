class Game::ClubTeamsController < ApplicationController
  before_action :set_club
  before_action :set_category
  before_action :set_team, only: %i[show edit update destroy]

  def index
    authorize! :read, Game::ClubTeam
    @teams = @category.club_teams.order(:name)
  end

  def show
    authorize! :read, @team
    @players = @team.players.order(:last_name, :first_name)
    @coaches = @team.coaches.order(:last_name, :first_name)
    @player_assignments = @team.player_cteam_joins.includes(:player)
  end

  def new
    @team = @category.club_teams.new(club: @club)
    authorize! :create, @team
  end

  def create
    @team = @category.club_teams.new(team_params.merge(club: @club))
    authorize! :create, @team

    if @team.save
      redirect_to game_club_category_team_path(@club, @category, @team), notice: 'Equipo creado.'
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
      redirect_to game_club_category_team_path(@club, @category, @team), notice: 'Equipo actualizado.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize! :destroy, @team
    @team.destroy!
    redirect_to game_club_category_teams_path(@club, @category), notice: 'Equipo eliminado.'
  end

  private

  def set_club
    @club = Game::Club.friendly.find(params[:club_id])
  end

  def set_category
    @category = @club.club_categories.find(params[:category_id])
  end

  def set_team
    @team = @category.club_teams.find(params[:id])
  end

  def team_params
    params.require(:game_club_team).permit(:name, :about, :mode)
  end
end
