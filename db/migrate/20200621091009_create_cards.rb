class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.integer :number
      t.date    :date
      t.string  :name
      t.integer :security
      t.references :user, type: :integer, foreign_key: true

      t.timestamps
    end
  end
end

