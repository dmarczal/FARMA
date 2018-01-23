require 'rails_helper'

RSpec.feature "Student::InteractivityWithTeams", type: :feature do
  let(:teacher) { create(:user, :actived) }
  let(:student) { create(:user, :actived) }
  let!(:team1) { create(:team, user: teacher) }
  let!(:team2) { create(:team, user: teacher) }
  let(:params) { {'register_code' => team1.code} }
 
  before do
    sign_in student
    visit '/student/teams'
  end

  it 'list all teams' do
    expect(page).to have_content(team1.name)
    expect(page).to have_content(team2.name)
  end
end
