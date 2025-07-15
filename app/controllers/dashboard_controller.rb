class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    case current_user.role
    when "super_admin"
      @users = User.all
      @clients = Client.all
      @documents = Document.all

    when "manager"
      @clients = Client.all

    when "supervisor", "data_entry_operator"
      @clients = Client.where(assigned_to_id: current_user.id)

    when "client"
      @clients = Client.where(user_id: current_user.id)
    end
  end
end
