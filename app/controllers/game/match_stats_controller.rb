class Game::MatchStatsController < ApplicationController
  before_action :set_match

  def show
    @stat = @match.match_stat
    authorize! :read, Game::MatchStat
    redirect_to new_game_match_stat_path(@match) if @stat.nil?
  end

  def new
    @stat = @match.build_match_stat
    authorize! :create, @stat
  end

  def create
    @stat = @match.build_match_stat(stat_params)
    authorize! :create, @stat

    if @stat.save
      redirect_to game_match_path(@match), notice: 'Estadística creada.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @stat = @match.match_stat
    authorize! :update, @stat
  end

  def update
    @stat = @match.match_stat
    authorize! :update, @stat

    if @stat.update(stat_params)
      redirect_to game_match_path(@match), notice: 'Estadística actualizada.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_match
    @match = Game::Match.find(params[:match_id])
  end

  def stat_params
    params.require(:game_match_stat).permit(:tries_a, :tries_b, :conversions_a, :conversions_b,
                                            :penalty_goal_a, :penalty_goal_b, :drop_goal_a, :drop_goal_b)
  end
end
