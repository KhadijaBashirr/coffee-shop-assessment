class OrderItem < ApplicationRecord
  validates :quantity, presence: true, numericality: { greater_than: 0 }

  belongs_to :order
  belongs_to :item

  before_create :calculate_price_with_tax

  private

  def calculate_price_with_tax
    order.update(total: order.total + (item.price + (Item.first.tax_bucket.percentage/100.to_f * Item.first.price)))
  end
end
