FactoryGirl.define do
  factory :introduction do
    title       {Faker::Name.name}
    content     {Faker::Name.name}
    position 0

    lo
  end

  factory :invalid_introduction, parent: :lo do
    title                  nil
  end
end
