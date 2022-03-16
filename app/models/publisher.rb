class Publisher < ApplicationRecord
  has_many :books, dependent: :destroy
  validates :name, presence: true, length: {maximum: Settings.max_name_length}
  validates :description, length: {maximum: Settings.max_description_length}
  validates :address, length: {maximum: Settings.max_address_length}
  validates :phone, numericality: {only_integer: true},
            length: {minimum: Settings.min_phone_length,
                     maximum: Settings.max_phone_length}
end
