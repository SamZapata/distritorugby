class Game::CategorySchedulesController < ApplicationController
  before_action :set_game_category_schedule, only: [:show, :edit, :update, :destroy]

  # GET /game/category_schedules
  # GET /game/category_schedules.json
  def index
    @game_category_schedules = Game::CategorySchedule.all
  end

  # GET /game/category_schedules/1
  # GET /game/category_schedules/1.json
  def show
  end

  # GET /game/category_schedules/new
  def new
    @game_category_schedule = Game::CategorySchedule.new
  end

  # GET /game/category_schedules/1/edit
  def edit
  end

  # POST /game/category_schedules
  # POST /game/category_schedules.json
  def create
    @game_category_schedule = Game::CategorySchedule.new(game_category_schedule_params)

    respond_to do |format|
      if @game_category_schedule.save
        format.html { redirect_to @game_category_schedule, notice: 'Category schedule was successfully created.' }
        format.json { render :show, status: :created, location: @game_category_schedule }
      else
        format.html { render :new }
        format.json { render json: @game_category_schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /game/category_schedules/1
  # PATCH/PUT /game/category_schedules/1.json
  def update
    respond_to do |format|
      if @game_category_schedule.update(game_category_schedule_params)
        format.html { redirect_to @game_category_schedule, notice: 'Category schedule was successfully updated.' }
        format.json { render :show, status: :ok, location: @game_category_schedule }
      else
        format.html { render :edit }
        format.json { render json: @game_category_schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /game/category_schedules/1
  # DELETE /game/category_schedules/1.json
  def destroy
    @game_category_schedule.destroy
    respond_to do |format|
      format.html { redirect_to game_category_schedules_url, notice: 'Category schedule was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game_category_schedule
      @game_category_schedule = Game::CategorySchedule.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_category_schedule_params
      params.require(:game_category_schedule).permit(:day, :start_time, :end_time)
    end
end
