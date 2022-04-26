class AddDeletedAtToBookAuthors < ActiveRecord::Migration[6.0]
  def change
    add_column :book_authors, :deleted_at, :datetime
    add_index :book_authors, :deleted_at
  end
end
