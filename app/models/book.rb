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
end
