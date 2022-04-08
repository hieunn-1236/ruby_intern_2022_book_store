class AddPriceToOrderDetail < ActiveRecord::Migration[6.0]
  def change
    add_column :order_details, :price, :decimal
  end
end
