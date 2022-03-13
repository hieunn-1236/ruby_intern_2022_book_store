class User < ApplicationRecord
  enum role: {user: 0, admin: 1}
  has_many :addresses, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :rates, dependent: :destroy
  has_many :books, through: :rates
end
