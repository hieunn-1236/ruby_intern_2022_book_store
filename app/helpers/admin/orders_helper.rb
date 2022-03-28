module Admin::OrdersHelper
  def total_on_book quantity, price
    quantity * price
  end

  def cal_purchase_price total, discount
    total * ((Settings.max_percent - discount) / Settings.max_percent)
  end

  def discount_percent discount
    return discount.percent if discount

    Settings.default_discount_percent
  end

  def total order_details
    order_details.reduce(0) do |sum, order_detail|
      sum + cal_purchase_price(
        total_on_book(order_detail.quantity,
                      order_detail.book_detail.book_price),
        discount_percent(order_detail.order.discount)
      )
    end
  end
end
