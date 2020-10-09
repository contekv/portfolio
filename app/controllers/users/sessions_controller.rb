class Users::SessionsController < Devise::SessionsController
  def test_guest
    @user = User.secure_guest("test@test.com")
    sign_in @user
    redirect_to home_path(resource), notice: "ゲストユーザーとしてログインしました"
  end

  def admin_login
    @user = User.secure_guest("admin@example.jp")
    sign_in @user
    redirect_to admin_path(resource), notice: "医療従事者としてログインしました"
  end
end