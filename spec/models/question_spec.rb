require 'rails_helper'

RSpec.describe Question, type: :model do
  before do
    @user = FactoryGirl.create(:user_actived)
    @lo = FactoryGirl.create(:lo, user: @user)
    @exercise = FactoryGirl.create(:exercise, lo: @lo)
  end

  context "create as new questions" do

    it "create a new question" do
      expect{
        question = FactoryGirl.create(:question, exercise: @exercise)
      }.to change(Question,:count).by(1)
    end

    it "questions couter" do
      question1 = FactoryGirl.create(:question, exercise: @exercise)
      question2 = FactoryGirl.create(:question, exercise: @exercise)
      expect(@exercise.questions_count).to eq 2
    end
  end

  it "dont save question" do
    question = FactoryGirl.create(:question, exercise: @exercise)
    question.title = nil
    expect(question.save).to eq false
  end
end
