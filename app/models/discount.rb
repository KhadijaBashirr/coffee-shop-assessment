class Discount < ApplicationRecord
  validates :percentage, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 100 }

  belongs_to :item
  belongs_to :required_item, class_name: 'Item'
end
