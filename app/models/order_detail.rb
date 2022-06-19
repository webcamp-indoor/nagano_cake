# == Schema Information
#
# Table name: order_details
#
#  id            :integer          not null, primary key
#  count         :integer          not null
#  making_status :integer          default("not_startable"), not null
#  price         :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  item_id       :integer          not null
#  order_id      :integer          not null
#
class OrderDetail < ApplicationRecord
  belongs_to :item
  belongs_to :order
  
  validates :count, presence: true, numericality: { only_integer: true }
  validates :price, presence: true, numericality: { only_integer: true }
  
  enum making_status: { not_startable: 0, waiting_making: 1, in_making: 2, making_complete: 3 }
  
  def subtotal
    (price * 1.1).floor * count
  end
end
