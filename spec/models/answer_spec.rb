require 'rails_helper'

RSpec.describe Answer, type: :model do
  let(:question) { create(:question, correct_answer: '10') }
  let(:exercise) { create(:exercise, lo: lo) }
  let(:lo)       { create(:lo, user: user) }
  let(:user)     { create(:user, :actived) }

  describe 'Create the answers' do
    context 'when has precision' do
      let(:question) { create(:question, correct_answer: '0.1234', precision: 2) }

      it "is correct" do
        answer = question.answers.new user_id: user.id, response: '0.1256'
        expect(answer).to be_correct
      end

      it "is incorrect" do
        answer = question.answers.new user_id: user.id, response: '0.1156'
        expect(answer).not_to be_correct
      end

      it "is invalid" do
        answer = question.answers.new user_id: user.id, response: 'x + 2'
        expect(answer).not_to be_correct
      end
    end

    context 'when precision is greater than decimal places' do
      describe 'correct answer is less than' do
        let(:question) { create(:question, correct_answer: '0.12', precision: 4) }

        it "is incorrect" do
          answer = question.answers.new user_id: user.id, response: '0.1256'
          expect(answer).not_to be_correct
        end

        it "is incorrect" do
          answer = question.answers.new user_id: user.id, response: '0.12'
          expect(answer).to be_correct
        end
      end

      describe 'response is less than' do
        let(:question) { create(:question, correct_answer: '0.1242', precision: 4) }

        it "is incorrect" do
          answer = question.answers.new user_id: user.id, response: '0.12'
          expect(answer).not_to be_correct
        end

        it "is incorrect" do
          answer = question.answers.new user_id: user.id, response: '0.1242'
          expect(answer).to be_correct
        end
      end
    end

    context 'when only one user responds' do
      it "is correct" do
        answer = question.answers.new user_id: user.id, response: '10'
        expect(answer).to be_correct
      end

      it 'has only one attempt' do
        answer = question.answers.new user_id: user.id, response: '10'

        expect(answer.attempt_number).to eq 1
      end

      it 'has two attempts' do
        question.answers.create user_id: user.id, response: '4'
        answer = question.answers.new user_id: user.id, response: '10'

        expect(answer.attempt_number).to eq 2
      end
    end

    context "when it's more than one user responding" do
      let(:user2) { create(:user, :actived) }

      it 'has only one attempt' do
        question.answers.create user_id: user2.id, response: '10'
        answer2 = question.answers.new user_id: user.id, response: '10'

        expect(answer2.attempt_number).to eq 1
      end
    end

    context 'when has team' do
      let(:user2) { create(:user, :actived) }
      let(:team) { create(:team, user: user) }

      before do
        team.users << user2
        team.lo = lo
      end

      it 'responses are separated by teams' do
        answer1 = question.answers.create user_id: user.id, response: '3'
        answer2 = question.answers.create user_id: user.id, response: '5', team_id: team.id
        answer3 = question.answers.new user_id: user.id, response: '10', team_id: team.id

        expect(answer1.attempt_number).to eq 1
        expect(answer2.attempt_number).to eq 1
        expect(answer3.attempt_number).to eq 2
      end
    end
  end
end
