class Game::UnionsController < ApplicationController
  before_action :set_union, only: %i[show edit update destroy]

  def index
    authorize! :read, Game::Union
    @unions = Game::Union.order(:name)
  end

  def show
    authorize! :read, @union
    @clubs = @union.clubs.order(:name)
  end

  def new
    @union = Game::Union.new
    authorize! :create, @union
  end

  def create
    @union = Game::Union.new(union_params)
    authorize! :create, @union

    if @union.save
      redirect_to game_union_path(@union), notice: 'Unión creada.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize! :update, @union
  end

  def update
    authorize! :update, @union

    if @union.update(union_params)
      redirect_to game_union_path(@union), notice: 'Unión actualizada.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize! :destroy, @union
    @union.destroy!
    redirect_to game_unions_path, notice: 'Unión eliminada.'
  end

  private

  def set_union
    @union = Game::Union.friendly.find(params[:id])
  end

  def union_params
    params.require(:game_union).permit(:name, :about, :founded, :website, :country, :abbr)
  end
end
