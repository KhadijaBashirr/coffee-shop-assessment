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
class TaxBucketSerializer < ActiveModel::Serializer
  attributes :tax_type, :percentage
end
