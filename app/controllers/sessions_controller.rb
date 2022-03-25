class SessionsController < ApplicationController
  before_action :find_user, only: :create
  def new; end

  def create
    if @user.authenticate params[:session][:password]
      login_remember @user
      if @user.user?
        redirect_to root_path
      else
        redirect_to admin_root_path
      end
    else
      flash.now[:danger] = t "invalid"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private
  def find_user
    @user = User.find_by email: params.dig(:session, :email)&.downcase
    return if @user

    flash[:danger] = t "not_exist"
    redirect_to root_url
  end
end
