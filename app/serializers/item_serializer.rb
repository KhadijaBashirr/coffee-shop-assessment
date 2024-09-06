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
class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :price, :created_at, :updated_at, :tax_bucket

  def tax_bucket
    TaxBucketSerializer.new(object.tax_bucket).attributes
  end
end
