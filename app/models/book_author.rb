class BookAuthor < ApplicationRecord
  belongs_to :author
  belongs_to :book
  delegate :author_id, to: :book_authors, prefix: true, allow_nil: true
  delegate :name, to: :author, prefix: true, allow_nil: true
end
