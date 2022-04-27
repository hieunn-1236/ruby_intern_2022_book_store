class Admin::ChartsController < Admin::AdminController
  def index
    @order_group_by_day = Order.group_by_day(:created_at).count
    @order_group_by_day_of_week = Order.group_by_day_of_week(:created_at,
                                                             format: "%a").count
    @order_group_status = Order.group(:status).count
    @order_group_by_category = Book.group(:category_id).sum(:price)

    @order_group_by_category = {}
    Category.all.includes(books: [book_details: :order_details]).each do |cate|
      @order_group_by_category[cate.name.to_s] = result_order(cate)
    end
  end

  private
  def result_order cate
    cate.books.map do |book|
      book.book_details.map{|bd| bd.order_details.pluck(:quantity).sum}.sum
    end .sum
  end
end
