class HomePagesController < ApplicationController
  before_action :load_products, only: :index
  def index
    @pagy, @new_products = pagy @products, items: Settings.page_items
    return @prices = @new_products.pluck(:price) unless params[:locale] == "vi"

    @prices = Book.dollar_to_vnd(@new_products)
  end

  private
  def load_products
    @products = Book.search(params[:search]).newest
  end
end
