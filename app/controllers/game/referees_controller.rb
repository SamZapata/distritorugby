class Game::RefereesController < ApplicationController
  before_action :set_game_referee, only: [:show, :edit, :update, :destroy]

  # GET /game/referees
  # GET /game/referees.json
  def index
    @game_referees = Game::Referee.all
  end

  # GET /game/referees/1
  # GET /game/referees/1.json
  def show
  end

  # GET /game/referees/new
  def new
    @game_referee = Game::Referee.new
  end

  # GET /game/referees/1/edit
  def edit
  end

  # POST /game/referees
  # POST /game/referees.json
  def create
    @game_referee = Game::Referee.new(game_referee_params)

    respond_to do |format|
      if @game_referee.save
        format.html { redirect_to @game_referee, notice: 'Referee was successfully created.' }
        format.json { render :show, status: :created, location: @game_referee }
      else
        format.html { render :new }
        format.json { render json: @game_referee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /game/referees/1
  # PATCH/PUT /game/referees/1.json
  def update
    respond_to do |format|
      if @game_referee.update(game_referee_params)
        format.html { redirect_to @game_referee, notice: 'Referee was successfully updated.' }
        format.json { render :show, status: :ok, location: @game_referee }
      else
        format.html { render :edit }
        format.json { render json: @game_referee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /game/referees/1
  # DELETE /game/referees/1.json
  def destroy
    @game_referee.destroy
    respond_to do |format|
      format.html { redirect_to game_referees_url, notice: 'Referee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game_referee
      @game_referee = Game::Referee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_referee_params
      params.require(:game_referee).permit(:first_name, :last_name, :identification, :birthdate, :eps, :about, :phone, :email)
    end
end
