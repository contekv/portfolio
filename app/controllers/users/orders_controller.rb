class Users::OrdersController < ApplicationController
  before_action :authenticate_user!
  ORDERS_LIMIT = 10

  def index
    @user = User.find(params[:user_id])
    @orders = Order.where(user_id: @user.id).page(params[:page]).per(ORDERS_LIMIT).sorted_desc
  end
end