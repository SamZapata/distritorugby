class Game::PlayerCteamJoinsController < ApplicationController
  before_action :set_club
  before_action :set_category
  before_action :set_team

  def create
    player = Game::Player.friendly.find(params.require(:player_id))
    assignment = @team.player_cteam_joins.new(player: player)
    authorize! :create, assignment

    if assignment.save
      redirect_to game_club_category_team_path(@club, @category, @team), notice: 'Jugador asignado al equipo.'
    else
      redirect_to game_club_category_team_path(@club, @category, @team), alert: assignment.errors.full_messages.to_sentence
    end
  end

  def destroy
    assignment = @team.player_cteam_joins.find(params[:id])
    authorize! :destroy, assignment
    assignment.destroy!
    redirect_to game_club_category_team_path(@club, @category, @team), notice: 'Asignación eliminada.'
  end

  private

  def set_club
    @club = Game::Club.friendly.find(params[:club_id])
  end

  def set_category
    @category = @club.club_categories.find(params[:category_id])
  end

  def set_team
    @team = @category.club_teams.find(params[:team_id])
  end
end
