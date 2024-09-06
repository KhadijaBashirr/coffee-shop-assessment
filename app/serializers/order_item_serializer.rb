class OrderItemSerializer < ActiveModel::Serializer
  attributes :id, :quantity, :discount, :created_at, :updated_at, :item, :price

  def item
    ItemSerializer.new(object.item).attributes
  end
end
