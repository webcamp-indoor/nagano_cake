class ChangeColumnDefaultToOrderDetails < ActiveRecord::Migration[6.1]
  def change
    change_column_default :order_details, :making_status, from: nil, to: "0"
  end
end
