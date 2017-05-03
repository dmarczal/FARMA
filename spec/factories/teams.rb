FactoryGirl.define do
  factory :team do
    name     {Faker::Name.name}
    code    {'12345'}

    user
  end
end
