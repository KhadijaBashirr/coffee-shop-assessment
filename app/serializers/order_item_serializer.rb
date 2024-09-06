# == Schema Information
#
# Table name: order_items
#
#  id         :bigint           not null, primary key
#  discount   :float            default(0.0)
#  price      :float            default(0.0)
#  quantity   :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  item_id    :bigint           not null, indexed
#  order_id   :bigint           not null, indexed
#
# Indexes
#
#  index_order_items_on_item_id   (item_id)
#  index_order_items_on_order_id  (order_id)
#
# Foreign Keys
#
#  fk_rails_...  (item_id => items.id)
#  fk_rails_...  (order_id => orders.id)
#
class OrderItemSerializer < ActiveModel::Serializer
  attributes :id, :quantity, :discount, :created_at, :updated_at, :item, :price

  def item
    ItemSerializer.new(object.item).attributes
  end
end
