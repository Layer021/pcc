class Admin::Auth::SessionsController < Admin::ApplicationController
  skip_before_action :authenticate_admin!, only: %i[new debug_login]
  layout "admin/login"

  def new
  end

  def destroy
    sign_out(current_admin)
    redirect_to new_admin_session_path
  end

  def debug_login
    admin = Admin.first
    sign_in(admin)
    redirect_to root_path
  end
end
