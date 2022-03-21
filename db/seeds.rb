5.times do
  name = Faker::Book.unique.genre
  description = Faker::Lorem.sentence(word_count: 5)
  Category.create!(name:name,
                  description: description
  )
end

5.times do
  name = Faker::Book.unique.publisher
  address = Faker::Address.full_address
  phone = Faker::PhoneNumber.phone_number
  description = Faker::Lorem.sentence(word_count: 5)
  Publisher.create!(name: name,
                    address: address,
                    phone: phone,
                    description: description
  )
end

50.times do
  name = Faker::Book.unique.title
  description = Faker::Lorem.sentence(word_count: 50)
  price = Faker::Commerce.price(range: 1..100.0, as_string: true)
  publish_year = Faker::Date.between(from: '2000-01-01', to: '2022-01-01')
  Book.create!(name: name,
               description: description,
               price: price,
               publish_year: publish_year,
               publisher_id: Publisher.all.pluck(:id).sample,
               category_id: Category.all.pluck(:id).sample
  )
end

50.times do
  edition = "Episode 1"
  quantity = Faker::Number.between(from: 5, to: 100)
  BookDetail.create!(edition: edition,
                     quantity: quantity,
                     book_id: Book.all.pluck(:id).sample
  )
end

5.times do
  name = Faker::Book.author
  description = Faker::Lorem.sentence(word_count: 10)
  Author.create!(name: name,
                  description: description
  )
end

50.times do
  BookAuthor.create!(book_id: Book.all.pluck(:id).sample,
                      author_id: Author.all.pluck(:id).sample
  )
end
