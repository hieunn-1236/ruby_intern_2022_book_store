FactoryBot.define do
  factory:address do
    receiver {Faker::Name.name}
    address {Faker::Address.street_address}
    phone {982423412}
    user_id {FactoryBot.create(:user).id}
  end
end
