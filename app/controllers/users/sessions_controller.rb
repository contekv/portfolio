class Users::SessionsController < Devise::SessionsController
  def test_guest
    @user = User.secure_guest("test@test.com")
    sign_in @user
    redirect_to home_path(resource), notice: "お試し頂き、ありがとうございます!"
  end
end