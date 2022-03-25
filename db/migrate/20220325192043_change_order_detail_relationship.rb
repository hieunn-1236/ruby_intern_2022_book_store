class ChangeOrderDetailRelationship < ActiveRecord::Migration[6.0]
  def up
    change_column_null :orders, :discount_id, true
    remove_reference :order_details, :book, index: false
    add_reference :order_details, :book_detail, null: false, foreign_key: true
    add_reference :orders, :address, null: false, foreign_key: true
  end
  def down
    change_column_null :orders, :discount_id, false
    add_reference :order_details, :book, null: false, foreign_key: true
    remove_reference :order_details, :book_detail, index: false
    remove_reference :orders, :address, index: false
  end
end
