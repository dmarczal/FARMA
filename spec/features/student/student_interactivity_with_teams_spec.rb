require 'rails_helper'

RSpec.feature "Student::InteractivityWithTeams", type: :feature do
  let!(:teacher) { create(:user_actived) }
  let!(:student) { create(:user_actived) }
  let!(:team1) { create(:team, user: teacher) }
  let!(:team2) { create(:team, user: teacher) }

  before do
    sing_in student
    visit '/student/teams'
  end

  it 'Should list all the teams' do
    expect(page).to have_content(team1.name)
    expect(page).to have_content(team2.name)
  end

  it 'Should register in team' do
    filds = {'register_code' => '12345'}
    fill_in_form(filds, "#register_form_#{team1.id}", 'input[type="submit"]')
    expect(team1.reload.users).to include(student)
  end
end
