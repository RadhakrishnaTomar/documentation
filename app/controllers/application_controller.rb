class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def authorize_super_admin!
    unless current_user&.super_admin?
      redirect_to root_path, alert: "Access denied. Super Admin only."
    end
  end
end
