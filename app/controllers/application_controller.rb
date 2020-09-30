class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    if current_user.admin?
      admin_path(resource)
    else
      home_path(resource)
    end
  end

  protected

    def sign_user
      redirect_to root_path unless user_signed_in?
    end

    def correct_admin
      redirect_to root_path unless current_user&.admin?
    end

    def correct_user
      user = User.find(params[:id])
      redirect_to root_path unless user == current_user
    end

    def set_user
      @user = User.find(params[:id])
    end

    def conversation
      if @user.conversations.present?
        @conversation_id = @user.conversations.first.id
      else
        @conversation = Conversation.new
      end
    end

    def configure_permitted_parameters
      added_attrs = [:name, :email, :password, :avatar, :password_confirmation　]
      devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
      devise_parameter_sanitizer.permit :account_update, keys: added_attrs
      devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
    end
end