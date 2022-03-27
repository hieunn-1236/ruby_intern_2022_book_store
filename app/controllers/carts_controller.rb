class CartsController < ApplicationController
  before_action :init_cart
  before_action :select_item, except: :create

  def new; end

  def index; end

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
        "book_id": @cart_params["book_id"].to_i,
        "quantity": @cart_params["quantity"].to_i
      }
    end
    flash[:success] = t "success"
    redirect_to root_url
  end

  def destroy
    @cart.delete_if{|line_item| line_item["book_id"] == params[:book_id].to_i}

    respond_to do |format|
      format.html{redirect_to carts_path}
      format.json{head :no_content}
    end
  end

  def update_quantity
    if params[:operator] == "+"
      @selected_item["quantity"] += 1
    elsif @selected_item["quantity"] > 1
      @selected_item["quantity"] -= 1
    end
    respond_to do |format|
      format.html{redirect_to carts_path}
      format.json{head :no_content}
    end
  end

  private
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
