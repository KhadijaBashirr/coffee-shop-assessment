class Taxbucket < ApplicationRecord
  self.table_name = 'taxbuckets'

  validates :tax_percentage, presence: true, numericality: { greater_than_or_equal_to: 0 }

  has_many :items, foreign_key: 'tax_bucket_id'
end
