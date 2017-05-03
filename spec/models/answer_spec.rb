require 'rails_helper'

RSpec.describe Answer, type: :model do

  describe 'initialize' do
    before do
      @user = FactoryGirl.create(:user_actived)
      @lo = FactoryGirl.create(:lo, user: @user)
      exercise = FactoryGirl.create(:exercise, lo: @lo)
      @question = FactoryGirl.create(:question, exercise: exercise, correct_answer: '10')
    end

    it "The answer must be correct after edit" do
      answer = @question.answers.new user_id: @user.id, response: '5'
      answer.response= 10

      expect(answer.correct).to eq true
    end

    context 'Have one user' do

      it 'the answer must be correct and have one attempt' do
        answer = @question.answers.new user_id: @user.id, response: '10'

        expect(answer.correct).to eq true
        expect(answer.attempt_number).to eq 1
      end

      it 'the answer must be correct and have two attempt' do
        answer1 = @question.answers.new user_id: @user.id, response: '4'
        answer1.save

        answer2 = @question.answers.new user_id: @user.id, response: '10'

        expect(answer2.correct).to eq true
        expect(answer2.attempt_number).to eq 2
      end

      it 'the answer must be correct and have two attempt' do
        answer1 = @question.answers.new user_id: @user.id, response: '4'
        answer1.save

        answer2 = @question.answers.new user_id: @user.id, response: '5'
        answer2.save

        answer3 = @question.answers.new user_id: @user.id, response: '8'

        expect(answer3.correct).to eq false
        expect(answer3.attempt_number).to eq 3
      end
    end

    context 'It has more than one user' do
      before do
        @user2 = FactoryGirl.create(:user_actived)
      end

      it 'the answer must be correct and have one attempt' do
        answer1 = @question.answers.new user_id: @user2.id, response: '10'
        answer1.save
        answer2 = @question.answers.new user_id: @user.id, response: '10'

        expect(answer2.correct).to eq true
        expect(answer2.attempt_number).to eq 1
      end
    end

    context 'Have teams' do
      before do
        @user2 = FactoryGirl.create(:user_actived)
        @team = FactoryGirl.create(:team, user: @user)
        user_team = @team.users_teams.new user_id: @user2.id
        user_team.save

        lo_team = @team.los_teams.new lo_id: @lo.id
        lo_team.save
      end

      it 'responses must be separated by teams' do
        answer1 = @question.answers.new user_id: @user.id, response: '3'
        answer1.save

        answer2 = @question.answers.new user_id: @user.id, response: '5', team_id: @team.id
        answer2.save

        answer3 = @question.answers.new user_id: @user.id, response: '10', team_id: @team.id

        expect(answer1.attempt_number).to eq 1
        expect(answer2.attempt_number).to eq 1
        expect(answer3.attempt_number).to eq 2
      end
    end
  end
end
