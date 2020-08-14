class AddDestinationKanaToAddress < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :destination_first_kana, :string
    add_column :addresses, :destination_last_kana, :string
  end
end