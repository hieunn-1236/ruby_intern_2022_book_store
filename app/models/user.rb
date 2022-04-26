class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :trackable, :timeoutable, :lockable,
         :omniauthable, omniauth_providers: [:google_oauth2]

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

  class << self
    def from_omniauth access_token
      data = access_token.info
      User.where(provider: access_token.provider, uid: access_token.uid)
          .find_or_create_by(email: data["email"]) do |u|
        u.name = data["name"]
        u.email = data["email"]
        u.password = Devise.friendly_token[0, 20]
        u.uid = access_token.uid
        u.provider = access_token.provider
      end
    end
  end

  private
  def downcase_email
    email.downcase!
  end
end
