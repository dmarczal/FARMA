require 'rails_helper'

RSpec.describe Team, type: :model do
  let(:team) { create(:team) }
  let(:team2) { create(:team) }
  let(:student) { create(:user, :actived) }

  context 'only register once' do
    it 'raise a RecordInvalid error' do
      student.register(code: '12345', id: team.id)

      expect{ 
        student.register(code: '12345', id: team.id)
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe 'scopes' do
    subject { Team.find_with_like(team.name) }

    it { is_expected.to include team }
    
    it 'returns just one team' do
      expect(subject.size).to eq(1)
    end

    it 'returns team opened' do
      team.update(opened: false)
      
      expect(subject.opened).to_not include team
    end
  end
end
