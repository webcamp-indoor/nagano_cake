class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
  end

  def confirm
    @cart_items = CartItem.all
    @order = current_customer.orders.new(order_params)
    @order.total_payment = @cart_items.inject(0) {|sum, item| sum + item.item.price*1.1*item.count }
    if params[:order][:address_select] == "0"
      @order.post_code = current_customer.post_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:address_select] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.post_code = @address.post_code
      @order.address = @address.address
      @order.name = @address.name
    end
  end

  def create
    cart_items = CartItem.all
    order = current_customer.orders.new(order_params)
    if order.save
      cart_items.each do |cart_item|
        order_detail = OrderDetail.new
        order_detail.order_id = order.id
        order_detail.item_id = cart_item.item_id
        order_detail.count = cart_item.count
        order_detail.price = cart_item.item.price
        order_detail.making_status = 0 #あとで設定する！
        order_detail.save
      end
      # cart_items.destroy_all
      redirect_to complete_orders_path
    end
  end

  def complete
  end

  def index
  end

  def show
  end

  private

  def order_params
    params.require(:order).permit(:address, :name, :payment_method, :post_code, :postage, :status, :total_payment)
  end
end
