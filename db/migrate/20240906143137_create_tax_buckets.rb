class CreateTaxBuckets < ActiveRecord::Migration[7.1]
  def change
    create_table :tax_buckets do |t|
      t.string :tax_type
      t.integer :percentage, null: false, default: 0

      t.timestamps
    end
  end
end
