class Discount < ApplicationRecord
  belongs_to :item
  belongs_to :required_item, class_name: 'Item'

  validates :discount_amount, presence: true, numericality: { greater_than: 0 }
  validates :item_id, uniqueness: { scope: :required_item_id }
end