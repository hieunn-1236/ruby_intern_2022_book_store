class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :set_locale
  include SessionsHelper

  private

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
end
