class Game::ClubTeamsController < ApplicationController
  before_action :set_game_club_team, only: [:show, :edit, :update, :destroy]

  # GET /game/club_teams
  # GET /game/club_teams.json
  def index
    @game_club_teams = Game::ClubTeam.all
  end

  # GET /game/club_teams/1
  # GET /game/club_teams/1.json
  def show
  end

  # GET /game/club_teams/new
  def new
    @game_club_team = Game::ClubTeam.new
  end

  # GET /game/club_teams/1/edit
  def edit
  end

  # POST /game/club_teams
  # POST /game/club_teams.json
  def create
    @game_club_team = Game::ClubTeam.new(game_club_team_params)

    respond_to do |format|
      if @game_club_team.save
        format.html { redirect_to @game_club_team, notice: 'Club team was successfully created.' }
        format.json { render :show, status: :created, location: @game_club_team }
      else
        format.html { render :new }
        format.json { render json: @game_club_team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /game/club_teams/1
  # PATCH/PUT /game/club_teams/1.json
  def update
    respond_to do |format|
      if @game_club_team.update(game_club_team_params)
        format.html { redirect_to @game_club_team, notice: 'Club team was successfully updated.' }
        format.json { render :show, status: :ok, location: @game_club_team }
      else
        format.html { render :edit }
        format.json { render json: @game_club_team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /game/club_teams/1
  # DELETE /game/club_teams/1.json
  def destroy
    @game_club_team.destroy
    respond_to do |format|
      format.html { redirect_to game_club_teams_url, notice: 'Club team was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game_club_team
      @game_club_team = Game::ClubTeam.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_club_team_params
      params.require(:game_club_team).permit(:name, :about, :birthdate)
    end
end
