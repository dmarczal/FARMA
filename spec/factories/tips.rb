FactoryBot.define do
  factory :tip do
    content     {Faker::Name.name}

    question
  end

  factory :invalid_tip, parent: :question do
    content                  nil
  end
end
