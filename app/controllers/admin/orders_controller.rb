class Admin::OrdersController < Admin::AdminController
  before_action :load_order_info, only: :index
  def index
    @pagy, @orders = pagy Order.all.order_newest
  end

  def load_order_info
    @book_details = BookDetail.all
  end
end
