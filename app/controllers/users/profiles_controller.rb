class Users::ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @profile = current_user.profile || current_user.create_profile!
    authorize! :read, @profile
  end

  def edit
    @profile = current_user.profile || current_user.create_profile!
    authorize! :update, @profile
  end

  def update
    @profile = current_user.profile || current_user.create_profile!
    authorize! :update, @profile

    if @profile.update(profile_params)
      redirect_to users_profile_path, notice: 'Perfil actualizado.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :about, :phone_number, :bithday)
  end
end
