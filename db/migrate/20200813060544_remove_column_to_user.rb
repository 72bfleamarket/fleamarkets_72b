class RemoveColumnToUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :profile, :text
    remove_column :users, :icons, :string
  end
end
