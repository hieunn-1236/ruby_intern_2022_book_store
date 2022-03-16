class Admin::BooksController < Admin::AdminController
  def index
    @products = Book.search(params[:admin_search]).newest
    @pagy, @new_products = pagy @products, items: Settings.page_items
    return @prices = @new_products.pluck(:price) unless is_vi_location?

    @prices = Book.dollar_to_vnds(@new_products)
  end
end
