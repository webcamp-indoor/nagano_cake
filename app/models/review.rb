# == Schema Information
#
# Table name: reviews
#
#  id          :integer          not null, primary key
#  content     :text
#  evaluation  :float
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  customer_id :integer
#  item_id     :integer
#
# Indexes
#
#  index_reviews_on_customer_id  (customer_id)
#  index_reviews_on_item_id      (item_id)
#
# Foreign Keys
#
#  customer_id  (customer_id => customers.id)
#  item_id      (item_id => items.id)
#
class Review < ApplicationRecord
  belongs_to :item
  belongs_to :customer
  
  validates :content, presence: true
  scope :reviews_with_id, -> { where.not(item_id: nil) }
end
