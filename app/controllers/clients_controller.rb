class ClientsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_super_admin_or_manager, only: [:new, :create, :destroy]
  before_action :set_users, only: [:new, :create]
  before_action :set_client, only: [:show, :edit, :update, :destroy]

  def index
    @clients = Client.all
  end

  def show
  end

  def new
    @client = Client.new
    @client.user_id = params[:user_id] if params[:user_id].present?
  end

  def edit
  end

  def create
    @client = Client.new(client_params)

    if @client.save
      email = User.find(@client.user_id).email
      @client.update(email: email)
      flash[:notice] = "Client created successfully."
      redirect_to clients_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @client.update(client_params)
      redirect_to client_path(@client), notice: "Client updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @client
      @client.destroy
      redirect_to clients_path, notice: "Client was successfully deleted."
    else
      redirect_to clients_path, alert: "Client not found."
    end
  end

  def assign_supervisor
    @client = Client.find(params[:id])
    authorize! :assign_supervisor, @client

    if @client.update(assigned_to_id: params[:client][:assigned_to_id])
      redirect_to clients_path, notice: "Supervisor assigned successfully."
    else
      redirect_to clients_path, alert: "Failed to assign supervisor."
    end
  end

  def assign_data_entry_operator
    client = Client.find(params[:id])
    if client.assigned_to_id == current_user.id 
      client.update(data_entry_operator_id: params[:client][:data_entry_operator_id])
      redirect_to dashboard_path, notice: "Data Entry Operator assigned successfully."
    else
      redirect_to dashboard_path, alert: "Unauthorized"
    end
  end

  private

  def client_params
    params.require(:client).permit(:name, :status, :user_id, :assigned_to_id)
  end

  def authorize_super_admin_or_manager
    unless current_user.super_admin? || current_user.manager?
      redirect_to root_path, alert: "Access denied."
    end
  end

  def set_users
    @users = User.where(role: :client)
  end

  def set_client
    @client = Client.find_by(id: params[:id])
  end
end
