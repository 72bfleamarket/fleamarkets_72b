class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :detal, null: false
      t.string :size, null: false
      t.string :brand
      t.string :condition, null: false
      t.string :postage, null: false
      t.string :region, null: false
      t.string :shipping_day, null: false
      t.integer :price, null: false
      t.integer :category_id
      t.timestamps
    end
    add_index :products, :name
    add_index :products, :price
  end
end
