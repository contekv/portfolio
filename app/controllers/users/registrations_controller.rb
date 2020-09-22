class Users::RegistrationsController < Devise::RegistrationsController
  before_action :check_guest, only: [:update, :destroy]

  def check_guest
    if @user.email == "test@test.com"
      redirect_to root_path, alert: "ゲストユーザーは編集・削除できません。"
    end
  end

  def after_sign_up_path_for(resource)
    home_path
  end

  def update_resource(resource, params)
    resource.update_without_current_password(params)
    if account_update_params[:avatar].present?
      resource.avatar.attach(account_update_params[:avatar])
    end
  end

  def after_update_path_for(resource)
    user_path(@user.id)
  end
end