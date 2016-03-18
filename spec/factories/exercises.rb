FactoryGirl.define do
  factory :exercise do
    title       {Faker::Name.name}
    content     {Faker::Name.name}

    lo
  end

  factory :invalid_exercise, parent: :lo do
    title                  nil
  end
end
