class CartsController < ApplicationController
  before_action :init_cart
  before_action :select_item, except: :create
  def create
    @cart_params = params[:cart]
    @cart.each do |line_item|
      if line_item["book_id"] == @cart_params["book_id"].to_i
        @current_item = line_item
      end
    end
    if @current_item.present?
      @current_item["quantity"] += @cart_params["quantity"].to_i
    else
      @cart << {
        @cart_params["book_id"] => @cart_params["quantity"].to_i
      }
    end
    redirect_to root_url
  end

  def destroy
    @cart.each do |line_item|
      @cart.delete line_item
    end
    redirect_to root_url
  end

  def update_quantity
    if params[:operator] == "+"
      @selected_item["quantity"] += 1
    else
      @selected_item["quantity"] -= 1
    end
  end

  private
  def init_cart
    session[:cart] ||= []
    @cart = session[:cart]
  end

  def select_item
    @cart.each do |line_item|
      if line_item["book_id"] == params[:book_id].to_i
        @selected_item = line_item
      end
    end
  end

  def cart_params
    params.require(:cart).permit :book_id, :quantity
  end
end
