class OrderItem < ApplicationRecord
  validates :quantity, presence: true, numericality: { greater_than: 0 }

  belongs_to :order
  belongs_to :item

  before_create :calculate_price

  private

  def calculate_price
    byebug
    order.update(total: order.total + item.price)
  end
end
