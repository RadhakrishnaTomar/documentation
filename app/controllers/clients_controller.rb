class ClientsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_super_admin_or_manager, only: [:new, :create]
  before_action :set_users, only: [:new, :create] 

  def new
    @client = Client.new
    @users = User.where(role: :client)
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      redirect_to clients_path, notice: "Client created successfully."
    else
      render :new , status: :unprocessable_entity
    end
  end

  private

  def client_params
    params.require(:client).permit(:name, :status, :user_id)
  end

  def authorize_super_admin_or_manager
    unless current_user.super_admin? || current_user.manager?
      redirect_to root_path, alert: "Access denied."
    end
  end

  def set_users
    @users = User.where(role: :client) 
  end
end
