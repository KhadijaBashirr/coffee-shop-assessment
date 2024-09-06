class Order < ApplicationRecord
  validates :status, presence: true

  belongs_to :customer, class_name: 'Customer', foreign_key: 'customer_id' , optional: true
  has_many :order_items
  has_many :items, through: :order_items

  enum status: { pending: 0, placed: 1, completed: 2, cancelled: 3 }
end
