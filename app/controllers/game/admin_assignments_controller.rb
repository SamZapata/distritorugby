class Game::AdminAssignmentsController < ApplicationController
  before_action :set_club
  before_action :authorize_super_admin

  def create
    user = User.club_admin.find(params.require(:user_id))
    assignment = @club.admin_assignments.new(user: user)

    if assignment.save
      redirect_to game_club_path(@club), notice: 'Administrador asignado al club.'
    else
      redirect_to game_club_path(@club), alert: assignment.errors.full_messages.to_sentence
    end
  end

  def destroy
    assignment = @club.admin_assignments.find(params[:id])
    assignment.destroy!
    redirect_to game_club_path(@club), notice: 'Asignación de administrador eliminada.'
  end

  private

  def set_club
    @club = Game::Club.friendly.find(params[:club_id])
  end

  def authorize_super_admin
    authorize! :manage, Game::ClubAdminAssignment
  end
end
