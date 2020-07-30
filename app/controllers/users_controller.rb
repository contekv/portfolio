class UsersController < ApplicationController

  before_action :sign_user
  before_action :authenticate_user!
  before_action :correct_user

  def show
    @user = User.find(params[:id])
  end

  def sign_user
    redirect_to root_path unless user_signed_in?
  end

  def correct_user
    user = User.find(params[:id])
    redirect_to root_path unless user == current_user
  end
end
