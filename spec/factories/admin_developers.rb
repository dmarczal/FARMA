FactoryBot.define do
  factory :admin_developer, class: 'Admin::Developer' do
    name "MyString"
    function "MyString"
    institution "MyString"
    link "MyString"
    start_on_project "2018-03-28"
    leave_project "2018-03-28"
    active false
  end
end
