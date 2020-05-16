class Game::MatchStatsController < ApplicationController
  before_action :set_game_match_stat, only: [:show, :edit, :update, :destroy]

  # GET /game/match_stats
  # GET /game/match_stats.json
  def index
    @game_match_stats = Game::MatchStat.all
  end

  # GET /game/match_stats/1
  # GET /game/match_stats/1.json
  def show
  end

  # GET /game/match_stats/new
  def new
    @game_match_stat = Game::MatchStat.new
  end

  # GET /game/match_stats/1/edit
  def edit
  end

  # POST /game/match_stats
  # POST /game/match_stats.json
  def create
    @game_match_stat = Game::MatchStat.new(game_match_stat_params)

    respond_to do |format|
      if @game_match_stat.save
        format.html { redirect_to @game_match_stat, notice: 'Match stat was successfully created.' }
        format.json { render :show, status: :created, location: @game_match_stat }
      else
        format.html { render :new }
        format.json { render json: @game_match_stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /game/match_stats/1
  # PATCH/PUT /game/match_stats/1.json
  def update
    respond_to do |format|
      if @game_match_stat.update(game_match_stat_params)
        format.html { redirect_to @game_match_stat, notice: 'Match stat was successfully updated.' }
        format.json { render :show, status: :ok, location: @game_match_stat }
      else
        format.html { render :edit }
        format.json { render json: @game_match_stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /game/match_stats/1
  # DELETE /game/match_stats/1.json
  def destroy
    @game_match_stat.destroy
    respond_to do |format|
      format.html { redirect_to game_match_stats_url, notice: 'Match stat was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game_match_stat
      @game_match_stat = Game::MatchStat.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_match_stat_params
      params.require(:game_match_stat).permit(:tries_a, :tries_b, :conversions_a, :conversions_b, :penalty_goal_a, :penalty_goal_b, :drop_goal_a, :drop_goal_b, :scrums_a, :scrums_b, :lines_a, :lines_b, :mauls_a, :mauls_b, :handling_a, :handling_b, :yellows_a, :yellows_b, :reds_a, :reds_b, :penalties_a, :penalties_b, :match_id)
    end
end
