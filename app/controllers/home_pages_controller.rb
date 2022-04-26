class HomePagesController < ApplicationController
  before_action :load_product, only: :show
  before_action :load_filter_options, only: %i(index show)
  authorize_resource class: false

  def index
    @products = @q.result
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

  def load_filter_options
    @categories = Category.pluck(:name, :id).unshift([t("all"), nil])
    @publishers = Publisher.pluck(:name, :id).unshift([t("all"), nil])
  end
end
