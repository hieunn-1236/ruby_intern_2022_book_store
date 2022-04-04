class HomePagesController < ApplicationController
  before_action :load_product, only: :show

  def index
    @products = Book.search(params[:search]).newest
    @pagy, @new_products = pagy @products, items: Settings.page_items
    return @prices = @new_products.pluck(:price) unless is_vi_location?

    @prices = Book.dollar_to_vnds(@new_products)
  end

  def show
    @book_details = @product.book_details
    return @price = @product.price unless is_vi_location?

    @price = @product.dollar_to_vnd
  end

  private
  def load_product
    @product = Book.includes(:book_details, :authors).find_by id: params[:id]
    return if @product

    flash[:danger] = t "book_not_found"
    redirect_to root_path
  end
end
