module CartsHelper
  def load_book id
    Book.find_by id: id
  end

  def load_book_detail id
    BookDetail.find_by id: id
  end

  def total_on_book quantity, price
    quantity * price
  end

  def total_order order_details
    order_details.reduce(0) do |sum, order_detail|
      sum + total_on_book(order_detail["quantity"],
                          load_book(order_detail["book_id"]).price)
    end
  end
end
