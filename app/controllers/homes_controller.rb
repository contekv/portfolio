class HomesController < ApplicationController
  before_action :sign_user
  before_action :authenticate_user!
  before_action :correct_user

  def show
    @user = User.find(params[:id])
    @order = @user.orders.build
  end
end