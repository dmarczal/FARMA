# This will guess the User class
FactoryGirl.define do
  factory :lo do
    name                  { Faker::Internet.name }
    description           { Faker::Internet.email }

    user_id               {create(:user)}
  end

  factory :invalid_lo, parent: :lo do
    name                  nil
  end
end
