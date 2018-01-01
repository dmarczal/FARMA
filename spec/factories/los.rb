FactoryBot.define do
  factory :lo do
    name                  { Faker::Internet.name }
    description           { Faker::Internet.email }

    user { create(:user, :actived) }
  end

  factory :invalid_lo, parent: :lo do
    name                  nil
  end
end
