class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :code, null: false
      t.string :area, null: false
      t.string :city, null: false
      t.string :village, null: false
      t.string :building
      t.integer :phone_number
      t.references :user, type: :integer, null: false, foreign_key: true

      t.timestamps
    end
    add_index :addresses, :area
    add_index :addresses, :city
  end
end
