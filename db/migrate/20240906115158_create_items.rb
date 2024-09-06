class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.decimal :price, precision: 10, scale: 2, null: false
      t.decimal :tax_rate, precision: 5, scale: 2, null: false
      t.references :category, foreign_key: true

      t.timestamps
    end
    add_index :items, :name, unique: true
  end
end