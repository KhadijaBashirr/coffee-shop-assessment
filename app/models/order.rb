# == Schema Information
#
# Table name: orders
#
#  id          :bigint           not null, primary key
#  status      :integer          default("pending"), not null
#  total       :decimal(10, 2)   default(0.0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  customer_id :integer
#
class Order < ApplicationRecord
  validates :status, presence: true

  belongs_to :customer, class_name: 'Customer', optional: true
  has_many :order_items, dependent: :destroy
  has_many :items, through: :order_items

  enum status: { pending: 0, placed: 1, completed: 2, cancelled: 3 }

  before_create :initialize_price

  private

  def initialize_price
    self.total = 0
  end
end
