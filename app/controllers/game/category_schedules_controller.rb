class Game::CategorySchedulesController < ApplicationController
  before_action :set_club
  before_action :set_category
  before_action :set_schedule, only: %i[show edit update destroy]

  def index
    authorize! :read, Game::CategorySchedule
    @schedules = @category.category_schedules.order(:day)
  end

  def show
    authorize! :read, @schedule
  end

  def new
    @schedule = @category.category_schedules.new
    authorize! :create, @schedule
  end

  def create
    @schedule = @category.category_schedules.new(schedule_params)
    authorize! :create, @schedule

    if @schedule.save
      redirect_to game_club_category_schedule_path(@club, @category, @schedule), notice: 'Horario creado.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize! :update, @schedule
  end

  def update
    authorize! :update, @schedule

    if @schedule.update(schedule_params)
      redirect_to game_club_category_schedule_path(@club, @category, @schedule), notice: 'Horario actualizado.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize! :destroy, @schedule
    @schedule.destroy!
    redirect_to game_club_category_schedules_path(@club, @category), notice: 'Horario eliminado.'
  end

  private

  def set_club
    @club = Game::Club.friendly.find(params[:club_id])
  end

  def set_category
    @category = @club.club_categories.find(params[:category_id])
  end

  def set_schedule
    @schedule = @category.category_schedules.find(params[:id])
  end

  def schedule_params
    params.require(:game_category_schedule).permit(:day, :start_time, :end_time)
  end
end
