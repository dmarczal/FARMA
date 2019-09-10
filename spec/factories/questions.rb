FactoryBot.define do
  factory :question do
    title       { Faker::Name.name }
    content     { Faker::Name.name }
    correct_answer { "a*5 + b" }

    exercise
  end

  factory :invalid_question, parent: :exercise do
    title { nil }
  end
end
