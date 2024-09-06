class CreateDiscounts < ActiveRecord::Migration[7.1]
  def change
    create_table :discounts do |t|
      t.references :item, null: false, foreign_key: true
      t.references :required_item, null: false, foreign_key: { to_table: :items }
      t.decimal :percentage, precision: 5, scale: 2, null: false, default: 0

      t.timestamps
    end
    add_index :discounts, [:item_id, :required_item_id], unique: true
  end
end
