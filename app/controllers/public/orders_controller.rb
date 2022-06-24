class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
  end

  def confirm
    @cart_items = CartItem.all
    @order = current_customer.orders.new(order_params)
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal } # 商品合計
    @order.total_payment = @total + @order.postage # 請求金額
    @address_select = params[:order][:address_select]
    if @address_select == "0"
      @order.post_code = current_customer.post_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif @address_select == "1"
      if Address.all.blank?
        flash[:alert] = "住所が登録されていません"
        redirect_to new_order_path
      else
        @address = Address.find(params[:order][:address_id])
        @order.post_code = @address.post_code
        @order.address = @address.address
        @order.name = @address.name
      end
    elsif @address_select == "2"
      if @order.invalid?
        flash[:alert] = "入力が間違っています"
        redirect_to new_order_path
      end
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
        order_detail.save
      end
      if params[:address_select] == "2"
        current_customer.addresses.create(address: order.address, name: order.name, post_code: order.post_code)
      end
      cart_items.destroy_all
      redirect_to complete_orders_path
    end
  end

  def complete
  end

  def index
    @orders = Order.pagination(10, params)
  end

  def show
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: @order.id)
    @total = @order.total_payment - @order.postage # 商品合計
  end

  private

  def order_params
    params.require(:order).permit(:address, :name, :payment_method, :post_code, :postage, :status, :total_payment)
  end
end
