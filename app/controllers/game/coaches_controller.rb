class Game::CoachesController < ApplicationController
  before_action :set_game_coach, only: [:show, :edit, :update, :destroy]

  # GET /game/coaches
  # GET /game/coaches.json
  def index
    @game_coaches = Game::Coach.all
  end

  # GET /game/coaches/1
  # GET /game/coaches/1.json
  def show
  end

  # GET /game/coaches/new
  def new
    @game_coach = Game::Coach.new
  end

  # GET /game/coaches/1/edit
  def edit
  end

  # POST /game/coaches
  # POST /game/coaches.json
  def create
    @game_coach = Game::Coach.new(game_coach_params)

    respond_to do |format|
      if @game_coach.save
        format.html { redirect_to @game_coach, notice: 'Coach was successfully created.' }
        format.json { render :show, status: :created, location: @game_coach }
      else
        format.html { render :new }
        format.json { render json: @game_coach.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /game/coaches/1
  # PATCH/PUT /game/coaches/1.json
  def update
    respond_to do |format|
      if @game_coach.update(game_coach_params)
        format.html { redirect_to @game_coach, notice: 'Coach was successfully updated.' }
        format.json { render :show, status: :ok, location: @game_coach }
      else
        format.html { render :edit }
        format.json { render json: @game_coach.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /game/coaches/1
  # DELETE /game/coaches/1.json
  def destroy
    @game_coach.destroy
    respond_to do |format|
      format.html { redirect_to game_coaches_url, notice: 'Coach was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game_coach
      @game_coach = Game::Coach.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_coach_params
      params.require(:game_coach).permit(:first_name, :last_name, :identification, :birthdate, :eps, :about, :phone, :email)
    end
end
