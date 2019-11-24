require 'rails_helper'

RSpec.describe Answer, type: :model do
  let(:question) { create(:question, correct_answer: '10') }
  let(:exercise) { create(:exercise, lo: lo) }
  let(:lo)       { create(:lo, user: user) }
  let(:user)     { create(:user, :actived) }

  describe 'validates' do
    it { is_expected.to validate_presence_of(:response) }
    it { is_expected.to validate_presence_of(:answer_tex) }
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_presence_of(:question) }
  end

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
        Answer.create user: user, question: question, response: '4', answer_tex: '4'
        answer = question.answers.new user_id: user.id, response: '10', answer_tex: '10'

        expect(answer.attempt_number).to eq 2
      end
    end

    context "when it's more than one user responding" do
      let(:user2) { create(:user, :actived) }

      it 'has only one attempt' do
        Answer.create user: user2, question: question, response: '10', answer_tex: '10'
        answer2 = Answer.new user: user, question: question, response: '10', answer_tex: '10'

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
        answer1 = Answer.create user: user2, question: question, response: '3', answer_tex: '3'
        answer2 = Answer.create user: user2, question: question, response: '5', answer_tex: '5', team: team
        answer3 = Answer.create user: user2, question: question, response: '10', answer_tex: '10', team: team

        expect(answer1.attempt_number).to eq 1
        expect(answer2.attempt_number).to eq 1
        expect(answer3.attempt_number).to eq 2
      end
    end
  end
end
