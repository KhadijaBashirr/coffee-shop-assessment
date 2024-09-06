class OrderSerializer < ActiveModel::Serializer
  attributes :id, :status, :total, :created_at, :updated_at

  has_many :order_items
end
