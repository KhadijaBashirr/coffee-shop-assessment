class RenameTypeColumnInTaxbuckets < ActiveRecord::Migration[7.1]
  def change
    rename_column :taxbuckets, :type, :tax_type
  end
end