# == Schema Information
#
# Table name: orders
#
#  id             :integer          not null, primary key
#  address        :string           not null
#  name           :string           not null
#  payment_method :integer          default("credit_card"), not null
#  post_code      :string           not null
#  postage        :integer          default(800), not null
#  status         :integer          default("payment_waiting"), not null
#  total_payment  :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  customer_id    :integer          not null
#
class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy

  validates :address, presence: true
  validates :name, presence: true
  validates :post_code, presence: true, length: { is: 7 }, numericality: { only_integer: true }
  validates :postage, presence: true, numericality: { only_integer: true }
  # validates :total_payment, presence: true, numericality: { only_integer: true }

  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { payment_waiting: 0, payment_confirmation: 1, in_making: 2, preparing_shipping: 3, shipping: 4 }

  scope :pagination, -> (count, params) { page(params[:page]).per(count) }
end
