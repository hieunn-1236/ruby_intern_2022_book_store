class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :book_detail, ->{with_deleted}
  delegate :edition, :quantity, to: :book_detail, prefix: true, allow_nil: true
  delegate :id, :discount_id, to: :order, prefix: true, allow_nil: true

  acts_as_paranoid
end
