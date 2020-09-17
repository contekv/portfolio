class OrdersController < ApplicationController
  layout "devise"
  before_action :authenticate_user!
  before_action :set_order, only: [:update, :destroy]
  ORDERS_LIMIT = 10

  def new
    @order = Order.new
  end

  def index
    @waiting_orders = Order.waiting.page(params[:waiting_page]).sorted_desc
    @running_orders = Order.running.page(params[:running_page]).sorted_desc
    @arrival_orders = Order.arrival.page(params[:arrival_page]).sorted_desc
    @completed_orders = Order.completed.page(params[:completed_page]).sorted_desc
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      redirect_to users_user_orders_path(@order.user), alert: "注文が完了しました"
    else
      redirect_back(fallback_location: users_user_orders_path(@order.user), alert: "注文が完了しませんでした")
    end
  end

  def update
    message =  @order.update(order_params) ? "更新しました" : "更新が完了していません"
    redirect_back(fallback_location: orders_path, alert: message)
  end

  def destroy
    @order.destroy
    redirect_to users_user_orders_path(@order.user), notice: "注文がキャンセルされました"
  end

  private

    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:content, :user_id, :order_type)
    end
end