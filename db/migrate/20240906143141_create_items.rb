class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.decimal :price, precision: 10, scale: 2, null: false, default: 0
      t.references :tax_bucket, foreign_key: true
      t.references :category, foreign_key: true

      t.timestamps
    end
    add_index :items, :name, unique: true
  end
end
