class ApplicationController < ActionController::Base

    protect_from_forgery with: :exception


=begin
    # deviseコントローラーにストロングパラメータ追加
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    def configure_permitted_parameters
      added_attrs = [:email, :name, :password, :password_confirmation, :remember_me, :admin]
      devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
      devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
      devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    end
=end

    # ログイン後のリダイレクト先
    def after_sign_in_path_for(resource)
      if current_user.admin
        admin_top_path(resource.id)
      else
        user_path(resource.id)
      end
    end
end
