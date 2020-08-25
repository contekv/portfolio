class Users::RegistrationsController < Devise::RegistrationsController
  def after_sign_up_path_for(resource)
    home_path
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
    if account_update_params[:avatar].present?
      resource.avatar.attach(account_update_params[:avatar])
    end
  end

  def after_update_path_for(resource)
    user_path(@user.id)
  end
end