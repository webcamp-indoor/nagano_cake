class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order_details = OrderDetail.where(order_id: @order_detail.order.id)
    @order_detail.update(order_detail_params)
    if @order_detail.making_status == "in_making"
      @order_detail.order.update(status: "in_making")
    elsif @order_detail.making_status == "making_complete"
      # 全ての製作ステータスが製作完了になったら注文ステータスを発送準備中にするための判定を行う
      @order_details.each do |order_detail|
        # 以下は、製作ステータスがmaking_completeではないときは注文ステータスをin_makingにして、
        # breakで処理を終了させる
        # 製作ステータスがmaking_completeのときは、注文ステータスをpreparing_shipping
        # もっといい実装方法があると思うが、良い方法が思いつかない
        if order_detail.making_status != "making_complete"
          @order_detail.order.update(status: "in_making")
          break
        end
        @order_detail.order.update(status: "preparing_shipping")
      end
    end
    redirect_to admin_order_path(@order_detail.order.id)
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
