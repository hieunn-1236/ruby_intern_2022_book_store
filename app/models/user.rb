class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: {user: 0, admin: 1}
  has_many :addresses, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :rates, dependent: :destroy
  has_many :books, through: :rates
  has_many :carts, dependent: :destroy

  attr_accessor :remember_token

  before_save :downcase_email

  validates :name, presence: true,
    length: {maximum: Settings.settings.user.username.max_length_50}

  scope :newest, ->{order(created_at: :desc)}

  private
  def downcase_email
    email.downcase!
  end
end
