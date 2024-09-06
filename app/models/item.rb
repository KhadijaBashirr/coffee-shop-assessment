class Item < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :category
  belongs_to :tax_bucket, class_name: 'TaxBucket', foreign_key: 'tax_bucket_id'
  has_many :order_items
  has_many :orders, through: :order_items
  has_many :discounts
  has_many :required_items, through: :discounts

  scope :grouped_by_category, -> {
    includes(:category).group_by { |item| item.category.name }
  }
end
