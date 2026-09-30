class Game::ClubCoachJoinsController < ApplicationController
  before_action :set_club

  def create
    coach = Game::Coach.friendly.find(params.require(:coach_id))
    assignment = @club.club_coach_joins.new(coach: coach)
    authorize! :create, assignment

    if assignment.save
      redirect_to game_club_path(@club), notice: 'Entrenador asignado al club.'
    else
      redirect_to game_club_path(@club), alert: assignment.errors.full_messages.to_sentence
    end
  end

  def destroy
    assignment = @club.club_coach_joins.find(params[:id])
    authorize! :destroy, assignment
    assignment.destroy!
    redirect_to game_club_path(@club), notice: 'Asignación eliminada.'
  end

  private

  def set_club
    @club = Game::Club.friendly.find(params[:club_id])
  end
end
