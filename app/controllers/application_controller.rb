class ApplicationController < ActionController::Base

  def after_sign_in_path_for(resource)
    if current_user.admin?
      admin_path(resource)
    else
      user_path(resource)
    end
  end
end