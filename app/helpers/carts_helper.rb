module CartsHelper
  def load_book id
    book = Book.find_by id: id
    return book if book

    flash[:danger] = t "not_exist"
    redirect_to root_url
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
