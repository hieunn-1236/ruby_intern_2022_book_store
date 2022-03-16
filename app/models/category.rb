class Category < ApplicationRecord
  has_many :books, dependent: :destroy
  validates :name, presence: true,
            length: {maximum: Settings.max_name_length}
  validates :description, length: {maximum: Settings.max_description_length}
end
