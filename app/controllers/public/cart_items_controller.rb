class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @cart_items = CartItem.where(customer:current_customer)
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
  end

  def create
    @cart_item = CartItem.new(cart_items_params)
    @cart_item.customer_id = current_customer.id
    # 商品がカートに存在するか確認
    @old_cart_item = CartItem.find_by(item: @cart_item.item)
    # カートに存在する？
    if @old_cart_item.present?
      @cart_item.count += @old_cart_item.count
      @old_cart_item.destroy
      if @cart_item.count > 20
        @cart_item.count = 20
        flash[:alert] = '1度に購入できる個数は20個までになります。'
      end
    end
    # 保存
    if @cart_item.save
      redirect_to cart_items_path
    else
      render "items/show"
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(count: params[:cart_item][:count].to_i)
    @cart_item.save
    redirect_to cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    @cart_items = current_customer.cart_items
    @cart_items.destroy_all
    redirect_to cart_items_path
  end

  private

  def cart_items_params
    params.require(:cart_item).permit(:customer_id, :item_id, :count)
  end
end