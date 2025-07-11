class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all if current_user.super_admin?
    @clients = case current_user.role.to_sym
               when :super_admin, :manager
                 Client.all
               when :supervisor, :data_entry_operator
                 Client.where(assigned_to_id: current_user.id)
               when :client
                 Client.where(user_id: current_user.id)
               else
                 Client.none
               end

    @documents = Document.all if current_user.super_admin?
  end
end
