FactoryBot.define do
  factory:discount do
    start_at {Faker::Time}
    end_at {Faker::Time}
    code {Faker::Number.between(from: 0, to: 100)}
    percent {Faker::Number.between(from: 0, to: 100)}
    quantity {Faker::Number.between(from: 0, to: 100)}
  end
end
