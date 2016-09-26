require 'rails_helper'

RSpec.describe TipsCount , type: :model do

  it "should be update field" do
    user = FactoryGirl.create(:user_actived)
    lo = FactoryGirl.create(:lo, user: user)
    exercise = FactoryGirl.create(:exercise, lo: lo)
    question = FactoryGirl.create(:question, exercise: exercise)
    team = FactoryGirl.create(:team, user: user)

    user_team = team.users_teams.new user_id: user.id
    user_team.save

    lo_team = team.los_teams.new lo_id: lo.id
    lo_team.save

    tips1 = question.tips_counts.new team_id: team.id, user_id: user.id
    tips1 = tips1.save_or_update

    tips2 = question.tips_counts.new team_id: team.id, user_id: user.id
    tips2 = tips2.save_or_update

    expect(TipsCount.count).to eq 1
    expect(tips2 == tips1).to eq true
  end
end
