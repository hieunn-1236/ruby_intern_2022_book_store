class Admin::BooksController < Admin::AdminController
  before_action :load_book_info, except: %i(index destroy)
  before_action :load_book, only: %i(update edit destroy)
  authorize_resource

  def index
    @products = Book.with_deleted.search(params[:admin_search]).newest
    @pagy, @new_products = pagy @products, items: Settings.page_items
    return @prices = @new_products.pluck(:price) unless is_vi_location?

    @prices = Book.dollar_to_vnds(@new_products)
  end

  def new
    @book = Book.new
    @book.book_details.build
    @book.book_authors.build
  end

  def create
    @book = Book.new book_params
    if @book.save
      flash[:success] = t ".success"
      redirect_to admin_books_path
    else
      flash.now[:danger] = t ".error"
      render :new
    end
  end

  def edit; end

  def update
    if @book.update book_params
      flash[:success] = t "update_book_success"
      redirect_to admin_root_path
    else
      flash.now[:danger] = t "update_book_fail"
      render :edit
    end
  end

  def destroy
    respond_to do |format|
      if @book.destroy
        format.js{flash.now[:notice] = t ".book_deleted"}
      else
        format.js{flash.now[:danger] = t ".delete_fail"}
      end
    end
  end

  def restore
    @book = Book.with_deleted.find_by(id: params[:id])
    respond_to do |format|
      if @book.restore(recursive: true)
        format.js{flash.now[:notice] = t ".book_restored"}
      else
        format.js{flash.now[:danger] = t ".restore_fail"}
      end
    end
  end

  private
  def load_book
    @book = Book.find_by(id: params[:id])
    return if @book

    flash.now[:danger] = t "book_not_found"
    render :index
  end

  def book_params
    params.require(:book)
          .permit(Book::BOOK_ATTRS)
  end

  def load_book_info
    @category = Category.pluck(:name, :id)
    @publishers = Publisher.pluck(:name, :id)
    @authors = Author.pluck(:name, :id)
  end
end
