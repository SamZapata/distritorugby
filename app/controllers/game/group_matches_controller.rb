class Game::GroupMatchesController < ApplicationController
  before_action :set_tournament
  before_action :set_group

  def create
    match = Game::Match.find(params.require(:match_id))
    assignment = @group.group_matches.new(match: match)
    authorize! :create, assignment

    if assignment.save
      redirect_to game_tournament_group_path(@tournament, @group), notice: 'Partido asignado al grupo.'
    else
      redirect_to game_tournament_group_path(@tournament, @group), alert: assignment.errors.full_messages.to_sentence
    end
  end

  def destroy
    assignment = @group.group_matches.find(params[:id])
    authorize! :destroy, assignment
    assignment.destroy!
    redirect_to game_tournament_group_path(@tournament, @group), notice: 'Asignación eliminada.'
  end

  private

  def set_tournament
    @tournament = Game::Tournament.friendly.find(params[:tournament_id])
  end

  def set_group
    @group = @tournament.groups.find(params[:group_id])
  end
end
