FactoryBot.define do
  factory:order do
    user_id {FactoryBot.create(:user).id}
    discount_id {FactoryBot.create(:discount).id}
    status {Faker::Number.between(from: 0, to: 2)}
    address_id {FactoryBot.create(:address).id}
  end
end
