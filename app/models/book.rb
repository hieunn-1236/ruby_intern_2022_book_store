class Book < ApplicationRecord
  belongs_to :category
  belongs_to :publisher
  has_many :book_details, dependent: :destroy
  has_many :book_authors, dependent: :destroy
  has_many :authors, through: :book_authors
  has_many :rates, dependent: :destroy
  has_many :users, through: :rates
  has_many :order_details, dependent: :destroy
  has_many :orders, through: :order_details

  scope :newest, ->{order(created_at: :desc)}

  scope :search,
        ->(search){where("name LIKE ?", "%#{search}%") if search.present?}

  class << self
    def dollar_to_vnd books
      books.map{|book| book.price = book.price * Settings.dollar_to_vnd}
    end
  end
end
