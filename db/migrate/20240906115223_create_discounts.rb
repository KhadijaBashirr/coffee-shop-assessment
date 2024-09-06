class CreateDiscounts < ActiveRecord::Migration[7.0]
  def change
    create_table :discounts do |t|
      t.references :item, null: false, foreign_key: true
      t.references :required_item, null: false, foreign_key: { to_table: :items }
      t.decimal :discount_amount, precision: 10, scale: 2, null: false

      t.timestamps
    end
    add_index :discounts, [:item_id, :required_item_id], unique: true
  end
end