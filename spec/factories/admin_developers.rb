FactoryBot.define do
  factory :admin_developer, class: 'Admin::Developer' do
    name                  {Faker::Name.name}
    function              {Faker::Job.title}
    institution           {Faker::Educator.university}
    link                  "https://www.google.com"
    active                true
    start_on_project      {Faker::Date.between(30.days.ago, Date.today)}

    trait :unactive do
      active              false
      leave_project       {Faker::Date.between(30.days.ago, Date.today)}
    end
  end
end
