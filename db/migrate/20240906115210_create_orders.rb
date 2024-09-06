class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.string :status, null: false, default: 'pending'
      t.decimal :total, precision: 10, scale: 2, null: false

      t.timestamps
    end
    add_index :orders, :status
  end
end