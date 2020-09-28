class Users::PasswordsController < Devise::PasswordsController
  prepend_before_action :require_no_authentication
  append_before_action :assert_reset_token_passed, only: :edit
  before_action :check_admin

  def new
    self.resource = resource_class.new
  end

  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    yield resource if block_given?

    if successfully_sent?(resource)
      respond_with({}, location: after_sending_reset_password_instructions_path_for(resource_name))
    else
      respond_with(resource)
    end
  end

  def edit
    self.resource = resource_class.new
    set_minimum_password_length
    resource.reset_password_token = params[:reset_password_token]
  end

  protected

    def check_admin
      if params[:user][:email].in?(["admin@example.jp", "test@test.com"])
        redirect_to root_path, alert: "管理者又はゲストユーザーはパスワードの再発行はできません。"
      end
    end

    def after_resetting_password_path_for(resource)
      Devise.sign_in_after_reset_password ? after_sign_in_path_for(resource) : new_session_path(resource_name)
    end

    def after_sending_reset_password_instructions_path_for(resource_name)
      new_session_path(resource_name) if is_navigational_format?
    end

    def assert_reset_token_passed
      if params[:reset_password_token].blank?
        set_flash_message(:alert, :no_token)
        redirect_to new_session_path(resource_name)
      end
    end

    def translation_scope
      "devise.passwords"
    end
end