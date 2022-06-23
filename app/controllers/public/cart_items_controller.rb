class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_cart_items, only: [:update, :destroy]

  def index
    @cart_items = CartItem.where(customer:current_customer)
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
  end

  def create
    @cart_item = current_customer.cartitems.new(cart_items_params)
    # 商品がカートに存在するか確認
    @old_cart_item = CartItem.find_by(item: @cart_item.item)
    # カートに入れた商品が、カート内に存在するか検証
    if @old_cart_item.present? and @cart_item.valid?
      # もしカート内にあれば、カート内にあった個数と新しく入れた個数を足す
      @cart_item.count += @old_cart_item.count
      # カート内にあった個数は消す
      @old_cart_item.destroy
    end
    # 保存する
    if @cart_item.save
      flash[:notice] = "カートに商品が追加されました"
      redirect_to cart_items_path
    else
      @item = Item.find(params[:cart_item][:item_id])
      @genres = Genre.all
      flash[:alert] = "個数が入力されていません"
      render "public/items/show"
    end
  end

  def update
    @cart_item.update(count: params[:cart_item][:count].to_i)
    flash[:notice] = "カート内の商品が変更されました"
    redirect_to cart_items_path
  end

  def destroy
    @cart_item.destroy
    flash[:notice] = "カート内の商品が削除されました"
    redirect_to cart_items_path
  end

  def destroy_all
    @cart_items = current_customer.cart_items
    @cart_items.destroy_all
    flash[:notice] = "カート内の全ての商品が削除されました"
    redirect_to cart_items_path
  end

  private

  def cart_items_params
    params.require(:cart_item).permit(:customer_id, :item_id, :count)
  end
  
  def set_cart_items
    @cart_item = CartItem.find(params[:id])
  end
end