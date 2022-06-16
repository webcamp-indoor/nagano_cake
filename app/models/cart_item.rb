# == Schema Information
#
# Table name: cart_items
#
#  id          :integer          not null, primary key
#  count       :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  customer_id :integer          not null
#  item_id     :integer          not null
#
class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item
end
