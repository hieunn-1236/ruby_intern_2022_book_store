class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(new create)
  before_action :load_user, except: %i(index new create)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: %i(destroy)
  authorize_resource

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      redirect_to root_url
    else
      flash.now[:danger] = t "failure"
      render :new
    end
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t "success"
      redirect_to @user
    else
      flash.now[:danger] = t "failure"
      render :edit
    end
  end

  def index
    @pagy, @user = pagy User.all.newest, items: Settings.page_items
  end

  def destroy
    if user.destroy
      flash[:success] = t "success"
    else
      flash.now[:danger] = t "failure"
    end
    redirect_to users_url
  end

  private
  def user_params
    params.require(:user).permit(:name, :email,
                                 :password, :password_confirmation)
  end

  def correct_user
    return if current_user?(@user)

    flash.now[:danger] = t "access"
    redirect_to root_url
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user

    flash.now[:danger] = t "not_exist"
    redirect_to :back
  end

  def admin_user
    return if current_user.admin?

    flash.now[:danger] = t "access"
    redirect_to root_url
  end
end
