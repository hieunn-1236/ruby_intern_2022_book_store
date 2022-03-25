class Order < ApplicationRecord
  belongs_to :user
  belongs_to :discount
  has_many :order_details, dependent: :destroy
  enum status: {pending: 0, accepted: 1, rejected: 2}

  accepts_nested_attributes_for :order_details
end
