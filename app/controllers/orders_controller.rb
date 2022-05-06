class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :init_order, only: :create
  before_action :load_order, only: %i(show update)

  authorize_resource

  def index
    @pagy, @orders = pagy Order.all
                               .by_user(current_user.id)
                               .includes(:user, :discount, :order_details)
                               .order_newest
  end

  def show
    respond_to do |format|
      format.js
    end
  end

  def update
    if handle_update_book
      flash["success"] = t "update_order_success"
    else
      flash["info"] = t "update_order_cancel"
    end
    redirect_to order_path
  end

  def create
    create_order_detail
    if @order.save
      session[:cart] = []
      flash[:success] = t "success"
      redirect_to root_url
    else
      flash.now[:danger] = t "error"
      redirect_to carts_path
    end
  end

  private
  def init_order
    @order = current_user.orders.new order_params
  end

  def order_params
    params.require(:order).permit :address_id, :discount_id
  end

  def status_params
    params.require(:order).permit :status
  end

  def create_order_detail
    @cart = session[:cart]
    @cart.each do |line_item|
      @order.order_details.build(
        quantity: line_item["quantity"],
        book_detail_id: line_item["book_detail_id"],
        price: line_item["price"]
      )
    end
  end

  def load_order
    @order = Order.includes(book_details: :book).find_by id: params[:id]
    return if @order

    flash[:danger] = t "not_found"
    redirect_to order_path
  end

  def handle_update_book
    ActiveRecord::Base.transaction do
      @order.update!(status: status_params["status"])
      return unless status_params["status"] == "accepted"
    end
  rescue ActiveRecord::RecordInvalid
    log "Oops. Update fails"
  end
end
