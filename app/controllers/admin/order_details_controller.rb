class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order_detail.update(order_detail_params)
    if @order_detail.making_status == "in_making"
      @order_detail.order.update(status: "in_making")
    end
    binding.pry
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
