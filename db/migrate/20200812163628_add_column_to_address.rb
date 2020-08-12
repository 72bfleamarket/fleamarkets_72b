class AddColumnToAddress < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :destination_first, :string
    add_column :addresses, :destination_last, :string
    add_column :addresses, :area_kana, :string, null: false
    add_column :addresses, :city_kana, :string, null: false
    add_column :addresses, :village_kana, :string, null: false
    add_column :addresses, :building_kana, :string
  end
end
