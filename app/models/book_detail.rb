class BookDetail < ApplicationRecord
  belongs_to :book
  validates :edition, presence: true,
            length: {maximum: Settings.max_edition_length}
  validates :quantity, presence: true,
            numericality: {only_integer: true,
                           greater_than_or_equal_to: Settings.min_val}
end
