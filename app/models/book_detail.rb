class BookDetail < ApplicationRecord
  belongs_to :book
  delegate :name, :id, :price, to: :book, prefix: true, allow_nil: true
  has_many :order_details, dependent: :destroy
  has_many :users, through: :order_details
  validates :edition, presence: true,
            length: {maximum: Settings.max_edition_length}
  validates :quantity, presence: true,
            numericality: {only_integer: true,
                           greater_than_or_equal_to: Settings.min_val}
end
