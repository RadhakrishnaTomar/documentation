class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :require_super_admin

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: "User created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end



  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "User updated successfully."
    else
      render :edit
    end
  end

  private

  def require_super_admin
    redirect_to root_path, alert: "Access denied." unless current_user.super_admin?
  end

  def user_params
    if action_name == 'create'
      params.require(:user).permit(:email, :password, :password_confirmation, :role)
    else
      params.require(:user).permit(:email, :role)
    end
  end
end
