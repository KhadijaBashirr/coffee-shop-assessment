# == Schema Information
#
# Table name: order_items
#
#  id         :bigint           not null, primary key
#  discount   :float            default(0.0)
#  price      :float            default(0.0)
#  quantity   :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  item_id    :bigint           not null, indexed
#  order_id   :bigint           not null, indexed
#
# Indexes
#
#  index_order_items_on_item_id   (item_id)
#  index_order_items_on_order_id  (order_id)
#
# Foreign Keys
#
#  fk_rails_...  (item_id => items.id)
#  fk_rails_...  (order_id => orders.id)
#
class OrderItem < ApplicationRecord
  validates :quantity, presence: true, numericality: { greater_than: 0 }

  belongs_to :order
  belongs_to :item

  after_create :calculate_price_with_tax

  private

  def calculate_price_with_tax
    discount_amount = calculate_discount
    self.discount = discount_amount

    if fixed_price_discount_applies?
      apply_fixed_price_discount
    else
      self.price = calculate_price(discount_amount)
    end

    order.update(total: order.total + price)
  end

  def apply_fixed_price_discount
    order.items.each do |order_item|
      order_item.price = 0
    end
  end

  def calculate_price(discount_amount)
    (item.price - discount_amount) + (item.price * item.tax_bucket.percentage / 100.to_f)
  end

  def fixed_price_discount_applies?
    applicable_discounts = DiscountDeal.where("? = ANY(item_ids)", item.id)
    applicable_discounts.any? do |deal|
      deal.discount_type == "fixed-price" || 
      (deal.item_ids - order.items.pluck(:item_id)).empty?
    end
  end

  def calculate_discount
    discount_deals = DiscountDeal.where("? = ANY(item_ids)", item.id)
    applicable_discounts = discount_deals.select do |deal|
      (deal.item_ids - order.items.pluck(:item_id)).empty?
    end

    applicable_discounts.reduce(0.0) do |total_discount, deal|
      total_discount + calculate_discount_amount(deal)
    end
  end

  def calculate_discount_amount(deal)
    case deal.discount_type
    when "fixed-discount"
      deal.discount_amount
    when "fixed-price"
      fixed_price_discount_amount(deal)
    when "percentage"
      (item.price * deal.discount_amount / 100)
    else
      0
    end
  end

  def fixed_price_discount_amount(deal)
    if (deal.item_ids - order.items.pluck(:item_id)).empty? && (order.items.pluck(:item_id) - deal.item_ids).empty?
      0
    else
      item.price
    end
  end
end
