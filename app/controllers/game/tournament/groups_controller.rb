class Game::Tournament::GroupsController < ApplicationController
  before_action :set_tournament
  before_action :set_group, only: %i[show edit update destroy]

  def index
    authorize! :read, Game::Tournament::Group
    @groups = @tournament.groups.order(:name)
  end

  def show
    authorize! :read, @group
    @matches = @group.matches.order(:play_date)
  end

  def new
    @group = @tournament.groups.new
    authorize! :create, @group
  end

  def create
    @group = @tournament.groups.new(group_params)
    authorize! :create, @group

    if @group.save
      redirect_to game_tournament_group_path(@tournament, @group), notice: 'Grupo creado.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize! :update, @group
  end

  def update
    authorize! :update, @group

    if @group.update(group_params)
      redirect_to game_tournament_group_path(@tournament, @group), notice: 'Grupo actualizado.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize! :destroy, @group
    @group.destroy!
    redirect_to game_tournament_groups_path(@tournament), notice: 'Grupo eliminado.'
  end

  private

  def set_tournament
    @tournament = Game::Tournament.friendly.find(params[:tournament_id])
  end

  def set_group
    @group = @tournament.groups.find(params[:id])
  end

  def group_params
    params.require(:game_tournament_group).permit(:name, :amount_teams)
  end
end
