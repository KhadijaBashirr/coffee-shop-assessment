class Item < ApplicationRecord
    belongs_to :category
    has_many :order_items
    has_many :orders, through: :order_items
    has_many :discounts
    has_many :required_items, through: :discounts
  
    validates :name, presence: true, uniqueness: true
    validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :tax_rate, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  end