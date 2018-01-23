FactoryBot.define do
  factory :question do
    title       {Faker::Name.name}
    content     {Faker::Name.name}
    correct_answer {"5"}

    exercise
  end

  factory :invalid_question, parent: :exercise do
    title                  nil
  end
end
