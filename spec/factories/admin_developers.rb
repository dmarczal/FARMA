FactoryBot.define do
  factory :admin_developer, class: 'Admin::Developer' do
    name                  {Faker::Name.name}
    function              {Faker::Job.title}
    institution           {Faker::Educator.university}
    link                  {Faker::Internet.url}
    active                true
    start_on_project      {Faker::Date.between(30.days.ago, Date.today)}

  end
end
