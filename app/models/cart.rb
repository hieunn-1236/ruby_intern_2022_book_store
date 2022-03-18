class Cart < ApplicationRecord
  has_many :books, through: :line_items
  belongs_to :user
end
