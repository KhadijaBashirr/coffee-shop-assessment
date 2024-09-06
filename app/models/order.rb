class Order < ApplicationRecord
  validates :status, presence: true
  validates :total, presence: true, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :customer
  has_many :order_items
  has_many :items, through: :order_items

  enum status: { pending: 0, completed: 1, cancelled: 2 }
end
