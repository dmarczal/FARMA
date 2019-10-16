FactoryBot.define do
  factory :team do
    name     { Faker::Name.name }
    code    { '12345' }
    opened { true }

    lo { create(:lo) }
    user  { create(:user, :actived) }
  end
end
