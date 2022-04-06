FactoryBot.define do
  factory :book_detail do
    book_id {FactoryBot.create(:book).id}
    edition {"Episode 1"}
    quantity {Faker::Number.between(from: 50, to: 100)}
  end
end
