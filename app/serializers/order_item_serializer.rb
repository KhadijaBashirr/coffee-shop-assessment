class OrderItemSerializer < ActiveModel::Serializer
  attributes :id, :quantity, :discount, :created_at, :updated_at, :item
end
