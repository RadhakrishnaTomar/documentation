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
   password = Devise.friendly_token.first(8)
   @user = User.new(user_params)
   @user.password = password
   @user.password_confirmation = password

   if @user.save
     UserMailer.send_credentials(@user, password).deliver_later unless @user.client?

     if @user.client?
      UserMailer.send_credentials(@user, password).deliver_later
       flash[:notice] = "User created and credentials sent to email. Please complete client details."
       redirect_to new_client_path(user_id: @user.id)
     else
       flash[:notice] = "User created and credentials sent to email."
       redirect_to admin_users_path
     end
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

  def destroy
    @user = User.find(params[:id])
    if @user
      @user.destroy
      redirect_to users_path, notice: "Client was successfully deleted."
    else
      redirect_to users_path, alert: "Client not found."
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
