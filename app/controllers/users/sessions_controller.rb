# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  def test_guest
    @user ||= User.find_by(email: "test@test.com")
    sign_in @user
    redirect_to user_path(resource), notice: "お試し頂き、ありがとうございます!"
  end
end