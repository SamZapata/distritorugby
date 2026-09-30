class Game::ClubsController < ApplicationController
  before_action :set_club, only: %i[show edit update destroy]

  def index
    authorize! :read, Game::Club
    @clubs = Game::Club.includes(:union).order(:name)
  end

  def show
    authorize! :read, @club

    return unless current_user&.super_admin?

    @club_admins = User.club_admin.order(:email)
    @admin_assignments = @club.admin_assignments.includes(:user)
  end

  def new
    @club = Game::Club.new
    authorize! :create, @club
    load_unions
  end

  def create
    @club = Game::Club.new(club_params)
    authorize! :create, @club

    if @club.save
      redirect_to game_club_path(@club), notice: 'Club creado.'
    else
      load_unions
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize! :update, @club
    load_unions
  end

  def update
    authorize! :update, @club

    if @club.update(club_params)
      redirect_to game_club_path(@club), notice: 'Club actualizado.'
    else
      load_unions
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize! :destroy, @club
    @club.destroy!
    redirect_to game_clubs_path, notice: 'Club eliminado.'
  end

  private

  def set_club
    @club = Game::Club.friendly.find(params[:id])
  end

  def load_unions
    @unions = Game::Union.order(:name)
  end

  def club_params
    permitted_attributes = %i[name about email phone address webpage instagram facebook twitter youtube]
    permitted_attributes << :union_id if current_user&.super_admin?

    params.require(:game_club).permit(*permitted_attributes)
  end
end
