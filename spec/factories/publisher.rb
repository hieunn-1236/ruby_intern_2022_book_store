FactoryBot.define do
  factory :publisher do
    name {Faker::Name.first_name}
    phone {1234567890}
  end
end
