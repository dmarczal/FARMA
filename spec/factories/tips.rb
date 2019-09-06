FactoryBot.define do
  factory :tip do
    content         { Faker::Name.name }
    number_of_tries { 4 }

    question
  end

  factory :invalid_tip, parent: :question do
    content { nil }
  end
end
