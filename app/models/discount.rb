class Discount < ApplicationRecord
  has_one :order, dependent: :destroy
end
