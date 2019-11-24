FactoryBot.define do
  factory :answer do
    response  { "2" }
    answer_tex  { "2" }
    question
    team
    user
  end
end
