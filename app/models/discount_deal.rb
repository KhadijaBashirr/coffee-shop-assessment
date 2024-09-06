# == Schema Information
#
# Table name: discount_deals
#
#  id              :bigint           not null, primary key
#  discount_amount :decimal(10, 2)
#  discount_name   :string           not null
#  discount_type   :string           not null
#  item_ids        :integer          default([]), is an Array
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class DiscountDeal < ApplicationRecord
  # Validations
  validates :discount_name, presence: true
  validates :item_ids, presence: true
  validates :discount_type, presence: true
  validates :discount_amount, numericality: { allow_nil: true }

  # You can add any additional methods or associations here
end
