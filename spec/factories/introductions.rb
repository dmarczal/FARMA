FactoryBot.define do
  factory :introduction do
    title       {Faker::Name.name}
    content     {Faker::Name.name}
    position    Time.now

    lo
  end

  factory :invalid_introduction, parent: :lo do
    title                  nil
  end
end
