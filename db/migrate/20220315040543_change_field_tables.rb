class ChangeFieldTables < ActiveRecord::Migration[6.0]
  def up
    change_column :categories, :description, :text
    change_column :authors, :description, :text
    change_column :publishers, :description, :text
    change_column :books, :description, :text
    change_column :rates, :content, :text
    add_column :books, :price, :decimal
    remove_column :book_details, :price
  end
  def down
    change_column :categories, :description, :string
    change_column :authors, :description, :string
    change_column :publishers, :description, :string
    change_column :books, :description, :string
    change_column :rates, :content, :string
    remove_column :books, :price
    add_column :book_details, :price, :decimal
  end
end
