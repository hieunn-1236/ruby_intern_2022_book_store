class Order < ApplicationRecord
  belongs_to :user
  belongs_to :discount
  has_many :order_details, dependent: :destroy
  has_many :line_items, dependent: :destroy
end
