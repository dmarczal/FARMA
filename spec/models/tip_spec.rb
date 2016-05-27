require 'rails_helper'

RSpec.describe Tip, type: :model do
  before do
    @user = FactoryGirl.create(:user_actived)
    @lo = FactoryGirl.create(:lo, user: @user)
    @exercise = FactoryGirl.create(:exercise, lo: @lo)
    @question = FactoryGirl.create(:question, exercise: @exercise)
  end

  context "create as new questions" do

    it "create a new question" do
      expect{
        tip = FactoryGirl.create(:tip, question: @question)
      }.to change(Tip,:count).by(1)
    end

  end

  it "dont save question" do
    tip = FactoryGirl.create(:tip, question: @question)
    tip.content = nil
    expect(tip.save).to eq false
  end
end
