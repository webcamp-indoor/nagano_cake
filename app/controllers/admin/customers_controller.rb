class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_customer,  only: [:show, :edit, :update,:destroy]

  def index
    @customers = Customer.page(params[:page]).per(10)
  end

  def show
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      redirect_to admin_customer_path(@customer), notice: '会員情報が更新されました'
    else
      flash.now[:alert] = '会員情報が更新できませんでした'
      render :edit
    end
  end

  def order_index
    @customer = Customer.find(params[:id])
    @orders = Order.where(customer_id: @customer.id).page(params[:page]).per(10)
  end

  private
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :post_code, :address, :phone_number, :email, :is_deleted)
  end

  def set_customer
    @customer = Customer.find(params[:id])
  end
end
