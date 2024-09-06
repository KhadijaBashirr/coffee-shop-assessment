class Order < ApplicationRecord
  validates :status, presence: true
  validates :total, presence: true, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :customer
  has_many :order_items
  has_many :items, through: :order_items

  enum status: { pending: 0, completed: 1, cancelled: 2 }

  before_save :calculate_total


  def calculate_total
    self.total = order_items.sum do |item|
      subtotal = item.item.price * item.quantity
      tax = subtotal * (item.item.tax_bucket.tax_percentage / 100)
      discount = calculate_discount(item)
      subtotal + tax - discount
    end
  end

  private

  def calculate_discount(order_item)
    discount = Discount.find_by(item: order_item.item)
    if discount && @order.order_items.exists?(item: discount.required_item)
      order_item.item.price * order_item.quantity * (discount.percentage / 100)
    else
      0
    end
  end
end
