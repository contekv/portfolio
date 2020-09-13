class OrdersController < ApplicationController
  layout "devise"
  before_action :authenticate_user!
  before_action :set_order, only: [:update, :destroy]

  def new
    @order = Order.new
  end

  def show
    @user = User.find(params[:id])
    @orders = Order.where(user_id: @user.id).page(params[:page]).per(10).sorted_desc
  end

  def index
    @orders0 = Order. waiting.page(params[:waiting_page]).sorted_desc
    @orders1 = Order.running.page(params[:running_page]).sorted_desc
    @orders2 = Order.arrival.page(params[:arrival_page]).sorted_desc
    @orders3 = Order.completed.page(params[:completed_page]).sorted_desc
  end

  def create
    @order = Order.new(order_params)
    message = @order.save ? "注文が完了しました" : "注文が完了されませんでした"
    redirect_to order_path(@order.user), alert: message
  end

  def update
    @order.update(order_params)
    redirect_back(fallback_location: orders_path, alert: "更新しました")
  end

  def destroy
    @order.destroy
    redirect_to order_path(@order.user), notice: "注文がキャンセルされました"
  end

  private

    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:content, :user_id, :order_type)
    end
end