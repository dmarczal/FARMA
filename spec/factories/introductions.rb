FactoryGirl.define do
  factory :introduction do
    title       {Faker::Name.name}
    content     {Faker::Name.name}

    lo
  end

  factory :invalid_introduction, parent: :lo do
    title                  nil
  end
end
