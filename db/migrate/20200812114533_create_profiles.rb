class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.text   :profile
      t.string :icon
      t.references :user, type: :integer, foreign_key: true
      t.timestamps

    end
  end
end
