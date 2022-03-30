# 5.times do
#   name = Faker::Book.unique.genre
#   description = Faker::Lorem.sentence(word_count: 5)
#   Category.create!(name:name,
#                   description: description
#   )
# end

# 5.times do
#   name = Faker::Book.unique.publisher
#   address = Faker::Address.full_address
#   phone = 1234567890
#   description = Faker::Lorem.sentence(word_count: 5)
#   Publisher.create!(name: name,
#                     address: address,
#                     phone: phone,
#                     description: description
#   )
# end

# 50.times do
#   name = Faker::Book.unique.title
#   description = Faker::Lorem.sentence(word_count: 50)
#   price = Faker::Commerce.price(range: 1..100.0, as_string: true)
#   publish_year = Faker::Date.between(from: '2000-01-01', to: '2022-01-01')
#   Book.create!(name: name,
#                description: description,
#                price: price,
#                publish_year: publish_year,
#                publisher_id: Publisher.all.pluck(:id).sample,
#                category_id: Category.all.pluck(:id).sample
#   )
# end

# 200.times do
#   edition = "Episode 1"
#   quantity = Faker::Number.between(from: 50, to: 100)
#   BookDetail.create!(edition: edition,
#                      quantity: quantity,
#                      book_id: Book.all.pluck(:id).sample
#   )
# end

# 5.times do
#   name = Faker::Book.author
#   description = Faker::Lorem.sentence(word_count: 10)
#   Author.create!(name: name,
#                   description: description
#   )
# end

# 50.times do
#   BookAuthor.create!(book_id: Book.all.pluck(:id).sample,
#                       author_id: Author.all.pluck(:id).sample
#   )
# end

# 10.times do |n|
#   name = Faker::Name.name
#   email = "user-#{n+1}@gmail.com"
#   password = "password"
#   User.create!(name: name,
#                email: email,
#                password: password,
#                password_confirmation: password,
#                role: 0,
#                activated: true,
#                activated_at: Time.zone.now)
# end

# User.create!(name: "abc",
#              email: "admin@gmail.com",
#              password: "password",
#              password_confirmation: "password",
#              role: 1,
#              activated: true,
#              activated_at: Time.zone.now)

# 20.times do |n|
#   start_at = Faker::Time.between(from: 2.days.ago, to: Time.now)
#   end_at = Faker::Time.forward(days: 100, period: :morning)
#   code = "code-#{n+1}"
#   percent = Faker::Number.between(from: 1, to: 100)
#   quantity = Faker::Number.between(from: 100, to: 500)
#   Discount.create!(start_at: start_at,
#                    end_at: end_at,
#                    code: code,
#                    percent: percent,
#                    quantity: quantity)
# end

# 30.times do
#   Address.create!(receiver: Faker::Name.name,
#                   address: Faker::Address.street_address,
#                   phone: 982423412,
#                   user_id: User.all.pluck(:id).sample)
# end

# discount_ids = []
# (1..20).map do |i|
#   discount_ids << i
# end

# 100.times do
#   user_id = User.all.pluck(:id).sample
#   Order.create!(user_id: user_id,
#                 discount_id: discount_ids.sample,
#                 status: Faker::Number.between(from: 0, to: 2),
#                 address_id: User.find(user_id.to_s).addresses.ids.sample)
# end

# 300.times do
#   OrderDetail.create!(order_id: Order.all.pluck(:id).sample,
#                       book_detail_id:  BookDetail.all.pluck(:id).sample,
#                       quantity: Faker::Number.between(from: 1, to: 5))
# end
