class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_order, only: [:show, :update]

  def show
    @order_details = OrderDetail.where(order_id: @order.id)
    @total = @order.total_payment - @order.postage # 商品合計
  end

  def update
    @order.update(order_params)
    if @order.status == "payment_confirmation"
      @order.order_details.each do |order_detail|
        order_detail.update(making_status: "waiting_making")
      end
    end
    flash[:notice] = "注文ステータスを更新しました"
    redirect_to admin_order_path(@order.id)
  end


  private

  def order_params
    params.require(:order).permit(:status)
  end

  def set_order
    @order = Order.find(params[:id])
  end

end
