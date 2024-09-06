class RenameDiscountsToDiscountDeals < ActiveRecord::Migration[7.1]
  def change
    rename_table :discounts, :discount_deals

    change_table :discount_deals do |t|
      t.string :discount_name, null: false  # Add discount name
      t.json :item_ids, null: false          # Store item IDs as an array
      t.string :discount_type, null: false    # Add type of discount
      t.decimal :discount_amount, precision: 10, scale: 2  # Add discount amount

      # Remove unnecessary fields
      t.remove :item_id                       # Remove item_id
      t.remove :required_item_id              # Remove required_item_id
      t.remove :percentage                     # Remove percentage
    end

  end
end