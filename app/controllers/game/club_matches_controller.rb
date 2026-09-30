class Game::ClubMatchesController < ApplicationController
  before_action :set_match

  def create
    club = Game::Club.friendly.find(params.require(:club_id))
    assignment = @match.club_matches.new(club: club)
    authorize! :create, assignment

    if assignment.save
      redirect_to game_match_path(@match), notice: 'Club asignado al partido.'
    else
      redirect_to game_match_path(@match), alert: assignment.errors.full_messages.to_sentence
    end
  end

  def destroy
    assignment = @match.club_matches.find(params[:id])
    authorize! :destroy, assignment
    assignment.destroy!
    redirect_to game_match_path(@match), notice: 'Asignación eliminada.'
  end

  private

  def set_match
    @match = Game::Match.find(params[:match_id])
  end
end
