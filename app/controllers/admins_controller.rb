class AdminsController < ApplicationController
  layout "devise"
  before_action :authenticate_user!
  before_action :correct_admin

  def show
    @user = User.find(params[:id])
  end
end