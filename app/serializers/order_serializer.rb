# == Schema Information
#
# Table name: orders
#
#  id          :bigint           not null, primary key
#  status      :integer          default("pending"), not null
#  total       :decimal(10, 2)   default(0.0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  customer_id :integer
#
class OrderSerializer < ActiveModel::Serializer
  attributes :id, :status, :total, :created_at, :updated_at

  has_many :order_items
end
