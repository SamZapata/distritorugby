class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :require_super_admin!
  before_action :set_user, only: %i[edit update]

  def index
    authorize! :manage, User
    @users = User.includes(:profile).order(:email)
  end

  def edit
    authorize! :update, @user
  end

  def update
    authorize! :update, @user

    if @user == current_user && demoting_self?
      redirect_to edit_admin_user_path(@user), alert: 'No puedes quitarte tu propio rol de super_admin.'
      return
    end

    if demoting_last_super_admin?
      redirect_to edit_admin_user_path(@user), alert: 'Debe existir al menos un super_admin.'
      return
    end

    if @user.update(admin_user_params)
      redirect_to admin_users_path, notice: 'Usuario actualizado.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def require_super_admin!
    authorize! :manage, :all
  end

  def set_user
    @user = User.find(params[:id])
  end

  def admin_user_params
    params.require(:user).permit(:role)
  end

  def demoting_self?
    admin_user_params[:role].present? && admin_user_params[:role] != 'super_admin'
  end

  def demoting_last_super_admin?
    @user.super_admin? && admin_user_params[:role].present? &&
      admin_user_params[:role] != 'super_admin' &&
      User.super_admin.where.not(id: @user.id).none?
  end
end
