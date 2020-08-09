class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    if current_user.admin?
      messages_path(resource)
    else
      user_path(resource)
    end
  end

  def correct_admin
    redirect_to root_path unless current_user&.admin?
  end
end