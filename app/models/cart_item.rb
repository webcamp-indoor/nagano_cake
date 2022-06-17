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
  
  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join("app/assets/images/no_image.jpeg")
      image.attach(io:File.open(file_path), filename:"default-image.jpg", content_type:"image/jpeg")
    end
    image.variant(resize_to_limit: [width, height]).processed
  end
  
  # カート機能/小計
  def subtotal
    item.tax_price * count
  end
end
