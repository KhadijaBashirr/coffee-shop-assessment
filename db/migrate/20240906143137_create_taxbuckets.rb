class CreateTaxbuckets < ActiveRecord::Migration[7.1]
  def change
    create_table :taxbuckets do |t|
      t.string :type
      t.decimal :tax_percentage, precision: 5, scale: 2, null: false
      t.float :tax

      t.timestamps
    end
  end
end
