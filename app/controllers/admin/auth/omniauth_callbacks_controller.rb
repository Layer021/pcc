class Admin::Auth::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    @admin = Admin.from_omniauth(request.env["omniauth.auth"])

    if @admin.present?
      sign_in_and_redirect @admin, event: :authentication
      set_flash_message(:notice, :success, kind: "Github") if is_navigational_format?
    else
      set_flash_message(:notice, :failure, kind: "Github", reason: "authentication error")
      failure
    end
  end

  def failure
    redirect_to new_admin_session_path
  end
end
