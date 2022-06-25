# == Schema Information
#
# Table name: addresses
#
#  id          :integer          not null, primary key
#  address     :string           not null
#  name        :string           not null
#  post_code   :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  customer_id :integer          not null
#
class Address < ApplicationRecord
  belongs_to :customer

  validates :address, presence: true
  validates :name, presence: true
  validates :post_code, presence: true, length: { is: 7 }, numericality: { only_integer: true }

  def address_display
    "〒" + post_code + " " + address + " " + name
  end
end
