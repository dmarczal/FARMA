require 'rails_helper'

RSpec.describe Team, type: :model do
  let!(:user) { create(:user_actived) }
  let!(:team) { create(:team, user: user) }
  let!(:team2) { create(:team, user: user) }
  let!(:student) { create(:user_actived) }

  it 'Should only register once' do
      student.register(code: '12345', id: team.id)

      expect{student.register(code: '12345', id: team.id)}.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'Should find with like query' do
    expect(Team.find_with_like(team.name)).to include team
    expect(Team.find_with_like(team.name).size).to eq 1
  end

  it 'Should find with like query only opened' do
    team.opened = false
    team.save
    expect(Team.find_with_like(team.name).opened).not_to include team
  end

end
