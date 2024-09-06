class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :items, through: :order_items

  validates :status, presence: true
  validates :total, presence: true, numericality: { greater_than_or_equal_to: 0 }

  accepts_nested_attributes_for :order_items

  before_validation :calculate_total

  private

  def calculate_total
    self.total = order_items.sum { |oi| oi.item.price * oi.quantity * (1 + oi.item.tax_rate / 100) }
    apply_discounts
  end

  def apply_discounts
    discounts = Discount.where(required_item_id: order_items.pluck(:item_id))
    discounts.each do |discount|
      self.total -= discount.discount_amount if order_items.exists?(item_id: discount.item_id)
    end
    self.total = [total, 0].max
  end
end
