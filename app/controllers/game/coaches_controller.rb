class Game::CoachesController < ApplicationController
  before_action :set_coach, only: %i[show edit update destroy]

  def index
    authorize! :read, Game::Coach
    @coaches = Game::Coach.order(:last_name, :first_name)
  end

  def show
    authorize! :read, @coach
    @clubs = @coach.clubs.order(:name)
    @teams = @coach.club_teams.order(:name)
  end

  def new
    @coach = Game::Coach.new
    authorize! :create, @coach
  end

  def create
    @coach = Game::Coach.new(coach_params)
    authorize! :create, @coach

    if @coach.save
      redirect_to game_coach_path(@coach), notice: 'Entrenador creado.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize! :update, @coach
  end

  def update
    authorize! :update, @coach

    if @coach.update(coach_params)
      redirect_to game_coach_path(@coach), notice: 'Entrenador actualizado.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize! :destroy, @coach
    @coach.destroy!
    redirect_to game_coaches_path, notice: 'Entrenador eliminado.'
  end

  private

  def set_coach
    @coach = Game::Coach.friendly.find(params[:id])
  end

  def coach_params
    params.require(:game_coach).permit(:first_name, :last_name, :about, :email, :phone)
  end
end
