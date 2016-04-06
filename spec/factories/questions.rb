FactoryGirl.define do
  factory :question do
    title       {Faker::Name.name}
    content     {Faker::Name.name}
    correct_answer {rand(100)}

    exercise
  end

  factory :invalid_question, parent: :exercise do
    title                  nil
  end
end
