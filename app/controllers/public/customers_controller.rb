class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_customer

  def show
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      flash[:notice] = "保存されました"
      redirect_to customers_path
    else
      flash[:alert] = "入力内容に誤りがあります"
      render :edit
    end
  end

  def confirm
  end

  def withdrawal
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @customer.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行しました"
    redirect_to root_path
  end

  private

  def set_customer
    @customer = current_customer
  end

  def customer_params
    params.require(:customer).permit(Customer.attribute_names)
  end
end
