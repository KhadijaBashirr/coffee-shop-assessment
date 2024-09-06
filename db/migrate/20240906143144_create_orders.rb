class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :customer, null: false, foreign_key: true
      t.integer :status, null: false, default: 0
      t.decimal :total, precision: 10, scale: 2, null: false

      t.timestamps
    end
    add_index :orders, :status
  end
end
