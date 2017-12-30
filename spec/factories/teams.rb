FactoryBot.define do
  factory :team do
    name     { Faker::Name.name }
    code    { '12345' }
    opened { true }

    user  { }
  end
end
