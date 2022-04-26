FactoryBot.define do
  factory :book_detail do
    book_id {FactoryBot.create(:book).id}
    edition {"Episode 1"}
    quantity {2}
    book
  end
end
