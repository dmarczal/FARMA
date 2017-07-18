require 'rails_helper'

RSpec.describe Team, type: :model do
  let!(:user) { create(:user_actived) }
  let!(:team) { create(:team, user: user) }
  let!(:student) { create(:user_actived) }

  it 'Should only register once' do
      student.register(code: '12345', id: team.id)

      expect{student.register(code: '12345', id: team.id)}.to raise_error(ActiveRecord::RecordInvalid)
  end

end
