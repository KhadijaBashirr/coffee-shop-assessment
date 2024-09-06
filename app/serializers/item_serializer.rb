class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :price, :created_at, :updated_at, :tax_bucket

  def tax_bucket
    TaxBucketSerializer.new(object.tax_bucket).attributes
  end
end
