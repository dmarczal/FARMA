FactoryBot.define do
  factory :admin_research, class: 'Admin::Research' do
    sequence(:title) { |n| "Pesquisa #{n}" }
    ref { "new ref: #{Faker::Date.between(2.days.ago, Date.today)}" }
    abstract { Faker::Lorem.paragraph(3) }
    link { Faker::Internet.url }
    research_category { create(:admin_research_category) }
  end
end
