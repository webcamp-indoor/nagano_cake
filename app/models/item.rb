# == Schema Information
#
# Table name: items
#
#  id           :integer          not null, primary key
#  introduction :text             not null
#  is_active    :boolean          default(TRUE), not null
#  name         :string           not null
#  price        :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  genre_id     :integer          not null
#
class Item < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  belongs_to :genre
  has_one_attached :image

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join("app/assets/images/no_image.jpeg")
      image.attached(io:File.open(file_path), filename:"default-image.jpg", content_type:"image/jpeg")
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

end
