class OrderItem < ApplicationRecord
  validates :quantity, presence: true, numericality: { greater_than: 0 }

  belongs_to :order
  belongs_to :item

  before_save :calculate_price_with_tax

  private

  def calculate_price_with_tax
    self.price = self.price + (item.price + (item.tax_bucket.percentage/100.to_f * item.price))
    order.update(total: order.total + (item.price + (item.tax_bucket.percentage/100.to_f * item.price)))
  end
end
