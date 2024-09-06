class ChangeItemIdsToIntegerArrayInDiscountDeals < ActiveRecord::Migration[7.1]
  def change
    # Remove the existing item_ids column
    remove_column :discount_deals, :item_ids, :json

    # Add the new item_ids column as an integer array
    add_column :discount_deals, :item_ids, :integer, array: true, default: []
  end
end