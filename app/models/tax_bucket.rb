# == Schema Information
#
# Table name: tax_buckets
#
#  id         :bigint           not null, primary key
#  percentage :integer          default(0), not null
#  tax_type   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class TaxBucket < ApplicationRecord
  validates :percentage, presence: true

  has_many :items
end
