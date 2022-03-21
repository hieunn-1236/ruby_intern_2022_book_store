module HomePagesHelper
  def option_selct_book_details book_details
    book_details.map do |book_detail|
      [book_detail.edition, book_detail.id,
        "data-quantity": book_detail.quantity]
    end
  end
end
