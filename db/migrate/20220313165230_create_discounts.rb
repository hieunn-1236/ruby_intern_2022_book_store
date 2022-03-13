class CreateDiscounts < ActiveRecord::Migration[6.0]
  def change
    create_table :discounts do |t|
      t.datetime :start_at
      t.datetime :end_at
      t.string :code
      t.float :percent
      t.integer :quantity

      t.timestamps
    end
  end
end
