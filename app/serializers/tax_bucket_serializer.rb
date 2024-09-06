class TaxBucketSerializer < ActiveModel::Serializer
  attributes :tax_type, :percentage
end
