class HomePagesController < ApplicationController
  def index
    products = Book.newest
    @pagy, @new_products = pagy products, items: Settings.page_items
    return @prices = @new_products.pluck(:price) unless params[:locale] == "vi"

    @prices = Book.dollar_to_vnd(@new_products)
  end
end
