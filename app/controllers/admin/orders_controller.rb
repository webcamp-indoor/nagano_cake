class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_order, only: [:show, :update]

  def show
    @order_details = OrderDetail.where(order_id: @order.id)
  end

  def update
    @order.update(order_params)
    if @order.status == "payment_confirmation"
      @order.order_details.each do |order_detail|
        order_detail.update(making_status: "waiting_making")
      end
    end
    redirect_to admin_order_path(@order.id)
  end

  def customer_index
    @customer = Customer.find(params[:id])
    @orders = @customer.orders
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end

  def set_order
    @order = Order.find(params[:id])
  end

end
