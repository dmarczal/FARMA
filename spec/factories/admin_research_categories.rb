FactoryBot.define do
  factory :admin_research_category, class: 'Admin::ResearchCategory' do
    sequence(:name) { |n| "Categoria de Pesquisa #{n}" }
  end
end
