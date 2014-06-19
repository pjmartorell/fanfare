class Admin::AdminController < ApplicationController
  before_filter :require_admin

  layout "backoffice"

  private

  def require_admin
    if !current_user
      flash[:error] = "Necessites estar autenticat."
      redirect_to new_user_session_path
    elsif !current_user.admin?
      flash[:error] = "Necessites ser administrador."
      redirect_to root_path
    end
  end
end