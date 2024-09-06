class TaxBucket < ApplicationRecord
  validates :tax_percentage, presence: true, numericality: { greater_than_or_equal_to: 0 }

  has_many :items, foreign_key: 'tax_bucket_id'
end
