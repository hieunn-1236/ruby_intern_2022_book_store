class CreateBookDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :book_details do |t|
      t.string :edition
      t.integer :quantity
      t.decimal :price
      t.references :book, null: false, foreign_key: true

      t.timestamps
    end
  end
end
