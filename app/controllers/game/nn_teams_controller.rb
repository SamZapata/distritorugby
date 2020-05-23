class Game::NnTeamsController < ApplicationController
  before_action :set_game_nn_team, only: [:show, :edit, :update, :destroy]

  # GET /game/nn_teams
  # GET /game/nn_teams.json
  def index
    @game_nn_teams = Game::NnTeam.all
  end

  # GET /game/nn_teams/1
  # GET /game/nn_teams/1.json
  def show
  end

  # GET /game/nn_teams/new
  def new
    @game_nn_team = Game::NnTeam.new
  end

  # GET /game/nn_teams/1/edit
  def edit
  end

  # POST /game/nn_teams
  # POST /game/nn_teams.json
  def create
    @game_nn_team = Game::NnTeam.new(game_nn_team_params)

    respond_to do |format|
      if @game_nn_team.save
        format.html { redirect_to @game_nn_team, notice: 'Nn team was successfully created.' }
        format.json { render :show, status: :created, location: @game_nn_team }
      else
        format.html { render :new }
        format.json { render json: @game_nn_team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /game/nn_teams/1
  # PATCH/PUT /game/nn_teams/1.json
  def update
    respond_to do |format|
      if @game_nn_team.update(game_nn_team_params)
        format.html { redirect_to @game_nn_team, notice: 'Nn team was successfully updated.' }
        format.json { render :show, status: :ok, location: @game_nn_team }
      else
        format.html { render :edit }
        format.json { render json: @game_nn_team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /game/nn_teams/1
  # DELETE /game/nn_teams/1.json
  def destroy
    @game_nn_team.destroy
    respond_to do |format|
      format.html { redirect_to game_nn_teams_url, notice: 'Nn team was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game_nn_team
      @game_nn_team = Game::NnTeam.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_nn_team_params
      params.require(:game_nn_team).permit(:name, :about, :birthdate)
    end
end
