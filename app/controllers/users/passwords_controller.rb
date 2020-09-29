class Users::PasswordsController < Devise::PasswordsController
  prepend_before_action :require_no_authentication
  append_before_action :assert_reset_token_passed, only: :edit
  before_action :check_admin

  protected

    def check_admin
      if params[:user][:email].in?(["admin@example.jp", "test@test.com"])
        redirect_to root_path, alert: "管理者又はゲストユーザーはパスワードの再発行はできません。"
      end
    end
end