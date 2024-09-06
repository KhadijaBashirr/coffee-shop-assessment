class Order < ApplicationRecord
  validates :status, presence: true

  belongs_to :customer, class_name: 'Customer', foreign_key: 'customer_id' , optional: true
  has_many :order_items
  has_many :items, through: :order_items

  enum status: { pending: 0, completed: 1, cancelled: 2 }
end
