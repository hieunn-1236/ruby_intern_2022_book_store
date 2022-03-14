class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :name
      t.string :description
      t.datetime :publish_year
      t.references :publisher, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
    add_index :books, :name
    add_index :books, :publish_year
  end
end
