class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_super_admin!
  before_action :set_user, only: [:show, :edit, :update]

  def index
    @users = User.all
  end

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "User updated successfully."
    else
      render :edit
    end
  end

  private

  def authorize_super_admin!
    redirect_to root_path, alert: "Access denied." unless current_user.super_admin?
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :role)
  end
end
