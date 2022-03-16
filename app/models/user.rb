class User < ApplicationRecord
  enum role: {user: 0, admin: 1}
  has_many :addresses, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :rates, dependent: :destroy
  has_many :books, through: :rates

  attr_accessor :remember_token

  before_save :downcase_email

  validates :name, presence: true,
    length: {maximum: Settings.settings.user.username.max_length_50}
  validates :email, presence: true,
    length: {maximum: Settings.settings.user.email.max_length_255},
    format: {with: Settings.settings.user.email.regex},
    uniqueness: true
  validates :password, presence: true,
    length: {minimum: Settings.settings.user.password.min_length_6},
    allow_nil: true

  has_secure_password

  class << self
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update_column :remember_digest, User.digest(remember_token)
  end

  def forget
    update_column :remember_digest, nil
  end

  def authenticated? attribute, token
    digest = send "#{attribute}_digest"
    return false unless digest

    BCrypt::Password.new(digest).is_password? token
  end

  private
  def downcase_email
    email.downcase!
  end
end
