class AddDeletedAtToBookDetails < ActiveRecord::Migration[6.0]
  def change
    add_column :book_details, :deleted_at, :datetime
    add_index :book_details, :deleted_at
  end
end
