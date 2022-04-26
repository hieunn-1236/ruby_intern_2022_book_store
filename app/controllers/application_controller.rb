class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :set_locale
  before_action :load_discount, :load_params
  include SessionsHelper
  rescue_from CanCan::AccessDenied, with: :access_denied

  def after_sign_in_path_for _resource
    admin_books_path
  end

  private

  def load_params
    @q = Book.ransack(params[:q])
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def is_vi_location?
    params[:locale] == "vi"
  end

  def init_cart
    session[:cart] ||= []
    @cart = session[:cart]
  end

  def logged_in_user
    return if logged_in?

    flash[:danger] = t "login_required"
    redirect_to login_url
  end

  def load_discount
    @discounts = Discount.all.pluck(:percent, :id)
  end

  def access_denied
    flash[:danger] = t "access"
    redirect_to root_url
  end
end
