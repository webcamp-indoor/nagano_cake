class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!

  def index
    @addresses = current_customer.addresses
    @address = Address.new
  end

  def create
    @addresses = current_customer.addresses.where.not(post_code: nil, name: nil, address: nil)
    @address = Address.new
    @address = current_customer.addresses.new(address_params)
    if @address.save
      # redirect_to addresses_path, notice: '配送先を追加しました'
      flash[:notice] = "配送先を追加しました"
    else
      flash[:alert] = '登録に失敗しました'
      # render "public/addresses/index"
    end
  end

  def edit
    @address = current_customer.addresses.find(params[:id])
  end

  def update
    @address = current_customer.addresses.find(params[:id])
    if @address.update(address_params)
      redirect_to addresses_path, notice: '配送先を変更しました'
    else
      flash.now[:alert] = '変更に失敗しました'
      render :edit
    end
  end

  def destroy
    @addresses = current_customer.addresses
    address = current_customer.addresses.find(params[:id])
    address.destroy
    # redirect_to addresses_path, notice: '配送先を削除しました'
    flash[:notice] = "配送先を削除しました"
  end

  private

  def address_params
    params.require(:address).permit(:post_code, :address, :name)
  end
end
