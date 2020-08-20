class UsersController < ApplicationController
  layout "devise"
  before_action :sign_user
  before_action :authenticate_user!
  before_action :correct_admin, only: [:index]

  def index
    @users = User.not_admin
  end

  def show
    @user = User.find(params[:id])
    @conversation = @user.conversations.ids
  end
end