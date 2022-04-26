class Book < ApplicationRecord
  BOOK_ATTRS = %i(name description price publish_year publisher_id
    category_id image).push(book_details_attributes: [:id, :edition, :quantity,
    :destroy]).push(author_ids: []).freeze
  belongs_to :category
  belongs_to :publisher
  has_many :book_details, dependent: :destroy
  has_many :book_authors, dependent: :destroy
  has_many :authors, through: :book_authors
  has_many :rates, dependent: :destroy
  has_many :users, through: :rates
  has_one_attached :image
  delegate :name, to: :category, prefix: true, allow_nil: true
  delegate :name, to: :publisher, prefix: true, allow_nil: true

  validates :name, presence: true, uniqueness: true,
            length: {maximum: Settings.max_name_book_length}
  validates :price, presence: true,
            format: {with: Settings.format_price},
            numericality: {greater_than: Settings.min_book_price_length,
                           less_than: Settings.max_book_price_length}
  validates :description, presence: true,
            length: {maximum: Settings.max_description_length}
  validates :image,
            content_type: {in: Settings.image_format,
                           message: I18n.t("invalid_format")},
            size: {less_than: Settings.image_size.megabytes,
                   message: I18n.t("invalid_size")}
  validates :category_id, presence: true
  validates :publisher_id, presence: true
  accepts_nested_attributes_for :book_details, :book_authors,
                                allow_destroy: true
  scope :newest, ->{order(created_at: :desc)}

  scope :search,
        ->(search){where("name LIKE ?", "%#{search}%") if search.present?}

  acts_as_paranoid

  def dollar_to_vnd
    price * Settings.dollar_to_vnd if price.present?
  end

  def display_image
    image.variant resize_to_limit: Settings.image_limit
  end

  ransacker :created_at, type: :date do
    Arel.sql("date(created_at)")
  end

  class << self
    def dollar_to_vnds books
      books.map(&:dollar_to_vnd)
    end

    def ransackable_attributes _auth_object = nil
      super %w(created_at) + _ransackers.keys
    end
  end
end
