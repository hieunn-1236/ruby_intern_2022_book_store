class Admin::BooksController < Admin::AdminController
  before_action :load_category_vs_publishers, only: %i(new create)
  before_action :load_book, only: :destroy

  def index
    @products = Book.search(params[:admin_search]).newest
    @pagy, @new_products = pagy @products, items: Settings.page_items
    return @prices = @new_products.pluck(:price) unless is_vi_location?

    @prices = Book.dollar_to_vnds(@new_products)
  end

  def new
    @product = Book.new
    @product.book_details.build
    @product.book_authors.build
  end

  def create
    @product = Book.new book_params
    if @product.save
      flash[:success] = t ".success"
      redirect_to admin_books_path
    else
      flash.now[:danger] = t ".error"
      render :new
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

  def load_category_vs_publishers
    @category = Category.pluck(:name, :id)
    @publishers = Publisher.pluck(:name, :id)
    @authors = Author.pluck(:name, :id)
  end
end
