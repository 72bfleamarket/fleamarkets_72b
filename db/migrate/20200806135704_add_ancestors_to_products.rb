class AddAncestorsToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :child_id, :integer
    add_column :products, :parent_id, :integer
  end
end
