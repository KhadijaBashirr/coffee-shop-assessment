class TaxBucket < ApplicationRecord
  validates :percentage, presence: true

  has_many :items, foreign_key: 'tax_bucket_id'
end
