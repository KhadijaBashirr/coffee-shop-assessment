# == Schema Information
#
# Table name: items
#
#  id            :bigint           not null, primary key
#  description   :text             not null
#  name          :string           not null, indexed
#  price         :decimal(10, 2)   default(0.0), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  category_id   :bigint           indexed
#  tax_bucket_id :bigint           indexed
#
# Indexes
#
#  index_items_on_category_id    (category_id)
#  index_items_on_name           (name) UNIQUE
#  index_items_on_tax_bucket_id  (tax_bucket_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (tax_bucket_id => tax_buckets.id)
#
class Item < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :category
  belongs_to :tax_bucket, class_name: 'TaxBucket'
  has_many :order_items,  dependent: :destroy
  has_many :orders, through: :order_items, dependent: :destroy
  has_many :discounts, dependent: :destroy
  has_many :required_items, through: :discounts, dependent: :destroy

  scope :grouped_by_category, lambda {
    includes(:category).group_by { |item| item.category.name }
  }
end
