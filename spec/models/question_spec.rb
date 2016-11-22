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

  context 'Content completion' do
    before do
      @user = FactoryGirl.create(:user_actived)
      @lo = FactoryGirl.create(:lo, user: @user)
      @exercise = FactoryGirl.create(:exercise, lo: @lo)
      @question = FactoryGirl.create(:question, exercise: @exercise, correct_answer: '10')

      @team = FactoryGirl.create(:team, user: @user)
      user_team = @team.users_teams.new user_id: @user.id
      user_team.save

      lo_team = @team.los_teams.new lo_id: @lo.id
      lo_team.save
    end

    it 'Should have visualized but not completed' do
      answer = @question.answers.new user_id: @user.id, response: '5', team_id: @team.id
      answer.save

      expect(@question.visualized).to eq true
      expect(@question.completed).to eq false
    end

    it 'Should have visualized and completed' do
      answer = @question.answers.new user_id: @user.id, response: '10', team_id: @team.id
      answer.save

      expect(@question.visualized).to eq true
      expect(@question.completed).to eq false
    end
  end
end
