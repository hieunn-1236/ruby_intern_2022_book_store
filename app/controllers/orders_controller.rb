class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :init_order, only: :create
  authorize_resource

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
end
