class Game::MatchesController < ApplicationController
  before_action :set_match, only: %i[show edit update destroy]

  def index
    authorize! :read, Game::Match
    @matches = Game::Match.order(:play_date)
  end

  def show
    authorize! :read, @match
    @clubs = @match.clubs.order(:name)
    @stat = @match.match_stat
    @groups = @match.groups
  end

  def new
    @match = Game::Match.new
    authorize! :create, @match
    load_referees
  end

  def create
    @match = Game::Match.new(match_params)
    authorize! :create, @match

    if @match.save
      redirect_to game_match_path(@match), notice: 'Partido creado.'
    else
      load_referees
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize! :update, @match
    load_referees
  end

  def update
    authorize! :update, @match

    if @match.update(match_params)
      redirect_to game_match_path(@match), notice: 'Partido actualizado.'
    else
      load_referees
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize! :destroy, @match
    @match.destroy!
    redirect_to game_matches_path, notice: 'Partido eliminado.'
  end

  private

  def set_match
    @match = Game::Match.find(params[:id])
  end

  def load_referees
    @referees = Game::Referee.order(:last_name, :first_name)
  end

  def match_params
    params.require(:game_match).permit(:play_date, :play_time, :emb_location, :address, :referee_id)
  end
end
