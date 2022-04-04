FactoryBot.define do
  factory:user do
    name {Faker::Name.name}
    email {Faker::Internet.email}
    password {"password"}
    password_confirmation {"password"}
    role {0}
    activated {true}
    activated_at {Time.zone.now}
  end
end
