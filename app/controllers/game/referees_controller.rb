class Game::RefereesController < ApplicationController
  before_action :set_referee, only: %i[show edit update destroy]

  def index
    authorize! :read, Game::Referee
    @referees = Game::Referee.order(:last_name, :first_name)
  end

  def show
    authorize! :read, @referee
  end

  def new
    @referee = Game::Referee.new
    authorize! :create, @referee
  end

  def create
    @referee = Game::Referee.new(referee_params)
    authorize! :create, @referee

    if @referee.save
      redirect_to game_referee_path(@referee), notice: 'Árbitro creado.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize! :update, @referee
  end

  def update
    authorize! :update, @referee

    if @referee.update(referee_params)
      redirect_to game_referee_path(@referee), notice: 'Árbitro actualizado.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize! :destroy, @referee
    @referee.destroy!
    redirect_to game_referees_path, notice: 'Árbitro eliminado.'
  end

  private

  def set_referee
    @referee = Game::Referee.friendly.find(params[:id])
  end

  def referee_params
    params.require(:game_referee).permit(:first_name, :last_name, :about, :email, :phone)
  end
end
