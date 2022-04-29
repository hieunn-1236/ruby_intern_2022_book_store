class Admin::OrdersController < Admin::AdminController
  before_action :load_order_info, only: :index
  before_action :load_order, except: :index
  before_action :order_params, only: :update
  authorize_resource

  def index
    @q = Order.ransack params[:q]
    @pagy, @orders = pagy @q.result.includes(:user, :discount,
                                             :order_details).order_newest
  end

  def show
    respond_to do |format|
      format.js
    end
  end

  def update
    if handle_update_quantity_book
      flash["success"] = t "update_order_success"
    else
      flash["info"] = t "update_order_reject"
    end
    send_mail_notification
    redirect_to admin_orders_path
  end

  private
  def order_params
    params.require(:order).permit(:status, :id)
  end

  def load_order
    @order = Order.includes(book_details: :book).find_by id: params[:id]
    return if @order

    flash[:danger] = t "not_found"
    redirect_to admin_order_path
  end

  def load_order_info
    @book_details = BookDetail.all
  end

  def handle_update_quantity_book
    ActiveRecord::Base.transaction do
      @order.update!(status: order_params["status"])
      return unless order_params["status"] == "accepted"

      ActiveRecord::Base.transaction(requires_new: true) do
        @order.order_details.each do |order_detail|
          order_detail.book_detail.update!(quantity:
            (order_detail.book_detail.quantity - order_detail.quantity))
        end
      end
    end
  rescue ActiveRecord::RecordInvalid
    log "Oops. Update fails"
  end

  def send_mail_notification
    if order_params["status"] == "accepted"
      @order.send_mail_approve
    elsif order_params["status"] == "rejected"
      @order.send_mail_reject
    end
  end
end
