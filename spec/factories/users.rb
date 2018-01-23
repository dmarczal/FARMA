FactoryBot.define do
  factory :user do
    name                  { Faker::Internet.name }
    email                 { Faker::Internet.email }
    password              { 12345678 }
    password_confirmation { 12345678 }

    trait :actived do
      confirmed_at Time.now
    end
  end
end

