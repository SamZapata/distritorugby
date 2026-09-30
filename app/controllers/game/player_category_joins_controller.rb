class Game::PlayerCategoryJoinsController < ApplicationController
  before_action :set_club
  before_action :set_category

  def create
    player = Game::Player.friendly.find(params.require(:player_id))
    assignment = @category.player_category_joins.new(player: player)
    authorize! :create, assignment

    if assignment.save
      redirect_to game_club_category_path(@club, @category), notice: 'Jugador asignado a la categoría.'
    else
      redirect_to game_club_category_path(@club, @category), alert: assignment.errors.full_messages.to_sentence
    end
  end

  def destroy
    assignment = @category.player_category_joins.find(params[:id])
    authorize! :destroy, assignment
    assignment.destroy!
    redirect_to game_club_category_path(@club, @category), notice: 'Asignación eliminada.'
  end

  private

  def set_club
    @club = Game::Club.friendly.find(params[:club_id])
  end

  def set_category
    @category = @club.club_categories.find(params[:category_id])
  end
end
