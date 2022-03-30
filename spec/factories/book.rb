FactoryBot.define do
  factory :book do
    name {Faker::Book.unique.title}
    description {Faker::Lorem.sentence(word_count: 50)}
    price {Faker::Commerce.price(range: 1..100.0, as_string: true)}
    publish_year {Faker::Date.between(from: '2000-01-01', to: '2022-01-01')}
    publisher_id {FactoryBot.create(:publisher).id}
    category_id {FactoryBot.create(:category).id}
  end
end
