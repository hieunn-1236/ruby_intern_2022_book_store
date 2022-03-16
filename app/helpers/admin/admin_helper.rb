module Admin::AdminHelper
  def selected_category book
    book.category.present? ? book.category.id : ""
  end

  def selected_publisher book
    book.publisher.present? ? book.publisher.id : ""
  end

  def selected_book_authors book
    book.book_authors.present? ? book.book_authors.pluck(:author_id) : ""
  end
end
